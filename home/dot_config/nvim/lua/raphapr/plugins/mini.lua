require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.bufremove").setup()
require("mini.surround").setup()
require("mini.pairs").setup({ mappings = { ["`"] = false } })
require("mini.notify").setup({ lsp_progress = { enable = false } })
vim.notify = require("mini.notify").make_notify()

-------------------------------------- hipatterns -------------------------------------
-- Hex colors (skipped in markdown and yaml) and TODO-style keywords.
local hipatterns = require("mini.hipatterns")
local hex_color = hipatterns.gen_highlighter.hex_color()
local hex_pattern = hex_color.pattern
hex_color.pattern = function(buf_id)
  local filetype = vim.bo[buf_id].filetype
  if filetype == "markdown" or filetype == "yaml" then
    return nil
  end
  return hex_pattern(buf_id)
end
hipatterns.setup({
  highlighters = {
    hex_color = hex_color,
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
  },
})

-------------------------------------- pick -------------------------------------------
-- Query history persisted across sessions (mini.pick has none built in).
local history_path = vim.fn.stdpath("state") .. "/mini-pick-history"
local history = vim.uv.fs_stat(history_path) and vim.fn.readfile(history_path) or {}
if #history > 1000 then
  history = vim.list_slice(history, #history - 999)
  vim.fn.writefile(history, history_path)
end
local history_index = #history + 1

local function recall(step)
  return function()
    local index = history_index + step
    if index < 1 or index > #history + 1 then
      return
    end
    history_index = index
    MiniPick.set_picker_query(vim.fn.split(history[index] or "", [[\zs]]))
  end
end

-- Move the selection half a window up (-1) or down (1) on screen. mini.pick has
-- no half-page move; with content_from_bottom, down on screen is a lower index.
local function half_page(direction)
  return function()
    local matches = MiniPick.get_picker_matches()
    if not matches or not matches.all_inds or #matches.all_inds == 0 then
      return
    end
    local current = 1
    for i, item_ind in ipairs(matches.all_inds) do
      if item_ind == matches.current_ind then
        current = i
        break
      end
    end
    local height = vim.api.nvim_win_get_height(MiniPick.get_picker_state().windows.main)
    local sign = MiniPick.get_picker_opts().options.content_from_bottom and -1 or 1
    local target = current + sign * direction * math.max(1, math.floor(height / 2))
    target = math.min(math.max(target, 1), #matches.all_inds)
    MiniPick.set_picker_match_inds({ matches.all_inds[target] }, "current")
  end
end

local pick_group = vim.api.nvim_create_augroup("MiniPickHistory", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = pick_group,
  pattern = "MiniPickStart",
  callback = function()
    history_index = #history + 1
  end,
})
vim.api.nvim_create_autocmd("User", {
  group = pick_group,
  pattern = "MiniPickStop",
  callback = function()
    local query = table.concat(MiniPick.get_picker_query() or {})
    if query == "" or history[#history] == query then
      return
    end
    table.insert(history, query)
    -- Append, so several Neovim instances don't overwrite each other's queries.
    vim.fn.writefile({ query }, history_path, "a")
  end,
})

require("mini.pick").setup({
  -- Prompt on the bottom border, best matches next to it (fzf-style).
  options = { content_from_bottom = true },
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",
    history_prev = { char = "<Up>", func = recall(-1) },
    history_prev_alt = { char = "<C-p>", func = recall(-1) },
    history_next = { char = "<Down>", func = recall(1) },
    delete_left = "", -- free <C-u> for half-page moves
    half_page_down = { char = "<C-d>", func = half_page(1) },
    half_page_up = { char = "<C-u>", func = half_page(-1) },
  },
  window = {
    prompt_prefix = "\u{f002}  ",
    -- A function, so the size follows terminal resizes.
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})
require("mini.extra").setup()

local pick, extra = MiniPick.builtin, MiniExtra.pickers

local function show_with_icons(buf_id, items, query)
  MiniPick.default_show(buf_id, items, query, { show_icons = true })
end

local function files()
  -- fd instead of the builtin so hidden files are listed, minus .git internals.
  pick.cli({
    command = { "fd", "--type=f", "--hidden", "--exclude=.git", "--color=never" },
  }, { source = { name = "Files", show = show_with_icons } })
end

local function grep_current()
  local text
  if vim.fn.mode():find("[vV\22]") then
    -- First line only: rg cannot search for a line break.
    text = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."))[1]
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  else
    text = vim.fn.expand("<cword>")
  end
  if text == "" then
    return
  end

  -- Mark every occurrence of the text in the code part of each result. rg runs
  -- with smart case, so match case only when the text has an uppercase letter.
  local smart_case = text:find("%u") == nil
  local needle = smart_case and text:lower() or text
  local ns = vim.api.nvim_create_namespace("raphapr_grep_current")
  local function show(buf_id, items, query)
    show_with_icons(buf_id, items, query)
    vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)
    for row, line in ipairs(vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)) do
      -- Results look like `path│line│col│code`: skip to the code.
      local code_start = 1
      for _ = 1, 3 do
        local _, sep_end = line:find("│", code_start, true)
        code_start = sep_end and sep_end + 1 or code_start
      end
      local haystack = smart_case and line:lower() or line
      local from = haystack:find(needle, code_start, true)
      while from do
        vim.api.nvim_buf_set_extmark(buf_id, ns, row - 1, from - 1, {
          end_col = from - 1 + #needle,
          hl_group = "MiniPickMatchRanges",
          priority = 200,
        })
        from = haystack:find(needle, from + #needle, true)
      end
    end
  end
  pick.grep({ pattern = text, method = "plain" }, { source = { show = show } })
end

local function zoxide()
  MiniPick.start({
    source = {
      name = "Zoxide",
      items = vim.fn.systemlist({ "zoxide", "query", "-l" }),
      choose = function(dir)
        vim.schedule(function()
          vim.cmd.cd(vim.fn.fnameescape(dir))
          vim.notify("cwd: " .. dir)
        end)
      end,
    },
  })
end

local function map(lhs, rhs, desc, mode)
  vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
end

map("<C-p>", files, "Find: Files")
map("<leader>ff", files, "Find: Files")
map("<leader>fg", pick.grep_live, "Find: Live grep")
map("<leader>fr", pick.resume, "Find: Resume last picker")
map("<leader>fs", grep_current, "Find: Current string", { "n", "x" })
map("<C-y>", pick.buffers, "Buffer: List")
map("<leader>bb", pick.buffers, "Buffer: List")
map("<leader>fh", pick.help, "Find: Help tags")
map("<leader>fk", extra.keymaps, "Find: Keymaps")
map("<leader>fc", function()
  extra.history({ scope = ":" })
end, "Find: Command history")
map("<leader>fe", function()
  extra.history({ scope = "/" })
end, "Find: Search history")
map("<leader>fo", extra.oldfiles, "Find: Old files")
map("<leader>fy", function()
  extra.lsp({ scope = "document_symbol" })
end, "Find: Document symbols")
map("<leader>fz", zoxide, "Find: Directory with zoxide")
map("<leader>ft", function()
  pick.grep({ pattern = [[\b(TODO|FIXME|HACK|NOTE)\b]] })
end, "Find: Project TODOs")
map("<leader>fu", function()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end, "Find: Undo tree")
map("<leader>gs", function()
  extra.git_files({ scope = "modified" })
end, "Git: Modified files")

-------------------------------------- keymaps ----------------------------------------
map("<C-e>", function()
  MiniBufremove.delete()
end, "Buffer: Delete")
map("<leader>bd", function()
  MiniBufremove.delete()
end, "Buffer: Delete")
-- Must stay a <Cmd> string: :nohlsearch has no effect when run inside a function.
map("<Esc>", "<Cmd>nohlsearch<Bar>lua MiniNotify.clear()<CR>", "Clear search highlight and notifications")

-------------------------------------- clue -------------------------------------------
local miniclue = require("mini.clue")
miniclue.setup({
  window = {
    delay = 500,
    config = {
      width = "60",
    },
  },
  triggers = {
    -- Leader triggers
    { mode = { "n", "x" }, keys = "<Leader>" },

    -- Navigation families
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = { "n", "x" }, keys = "g" },
    { mode = "n", keys = "<C-w>" },
    { mode = { "n", "x" }, keys = "z" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- Marks
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },

    -- Registers
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
  },
  clues = {
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),

    -- Normal mode
    { mode = "n", keys = "<leader>f", desc = "Find" },
    { mode = "n", keys = "<leader>b", desc = "Buffers" },
    { mode = "n", keys = "<leader>g", desc = "Git" },
    { mode = "n", keys = "<leader>x", desc = "Diagnostics" },
    { mode = "n", keys = "<leader>e", desc = "Edit" },
    { mode = "n", keys = "<leader>m", desc = "Miscellaneous" },
    { mode = "n", keys = "<leader>z", desc = "zk" },
    { mode = "n", keys = "<leader>l", desc = "LSP" },
    { mode = "n", keys = "<leader>y", desc = "Yank" },
    { mode = "n", keys = "<leader>r", desc = "Review" },
    { mode = "n", keys = "go", desc = "Go" },
    { mode = "n", keys = "gr", desc = "LSP" },

    -- Visual mode
    { mode = "x", keys = "<leader>f", desc = "Find" },
    { mode = "x", keys = "<leader>g", desc = "Git" },
    { mode = "x", keys = "<leader>b", desc = "Base64" },
    { mode = "x", keys = "<leader>z", desc = "zk" },
    { mode = "x", keys = "<leader>y", desc = "Yank" },
    { mode = "x", keys = "<leader>r", desc = "Review" },
  },
})
