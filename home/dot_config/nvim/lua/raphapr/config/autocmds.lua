-- One group so re-sourcing this file (e.g. <leader>mr) replaces instead of duplicating.
local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Use Neovim's built-in syntax until tmux reaches nvim-treesitter's main branch.
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "tmux",
  callback = function(event)
    vim.cmd.syntax("enable")
    vim.bo[event.buf].syntax = "tmux"
  end,
})

-- YAML file settings
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "yaml",
  callback = function()
    -- Use 2-space indentation for YAML
    vim.api.nvim_command("setlocal ts=2 sts=2 sw=2 expandtab")
  end,
})

-- jump to the last place you’ve visited in a file
local skip_last_position = {
  COMMIT_EDITMSG = true,
  MERGE_MSG = true,
  TAG_EDITMSG = true,
  ["git-rebase-todo"] = true,
}
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(event)
    -- Check the file name too: filetype detection may not have run yet.
    local filetype = vim.bo[event.buf].filetype
    if filetype == "gitcommit" or filetype == "gitrebase" or skip_last_position[vim.fs.basename(event.file)] then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount and pcall(vim.api.nvim_win_set_cursor, 0, mark) then
      vim.cmd("normal! zv") -- foldlevelstart=0 would otherwise leave the cursor in a closed fold
    end
  end,
})

-- Highlight yank region
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- Window-local highlights must follow the buffer displayed in each window.
local buffer_highlight_group = vim.api.nvim_create_augroup("BufferHighlights", { clear = true })
local zk_hashtag_pattern = [[\v(^|[[:space:]\[({])\zs#[A-Za-z][A-Za-z0-9_/-]*]]

vim.api.nvim_set_hl(0, "ZkHashtag", { link = "Identifier", default = true })
vim.api.nvim_set_hl(0, "YamlTabError", { link = "Error", default = true })

local function resolved_path(path)
  if not path or path == "" then
    return ""
  end

  return (vim.fs.normalize(vim.fn.resolve(vim.fn.fnamemodify(path, ":p"))):gsub("/$", ""))
end

-- Resolved once: this autocmd runs on every WinEnter.
local notebook_dir = resolved_path(vim.env.ZK_NOTEBOOK_DIR)

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType", "WinEnter" }, {
  group = buffer_highlight_group,
  callback = function(event)
    for _, win in ipairs(vim.fn.win_findbuf(event.buf)) do
      vim.api.nvim_win_call(win, function()
        for _, match in ipairs(vim.fn.getmatches()) do
          if match.group == "ZkHashtag" or match.group == "YamlTabError" then
            vim.fn.matchdelete(match.id)
          end
        end

        local filetype = vim.bo[event.buf].filetype
        if filetype == "yaml" or filetype == "yml" then
          vim.fn.matchadd("YamlTabError", [[\t]])
        end
        if filetype ~= "markdown" then
          return
        end

        local buffer_path = resolved_path(vim.api.nvim_buf_get_name(event.buf))
        if notebook_dir ~= "" and vim.startswith(buffer_path, notebook_dir .. "/") then
          vim.fn.matchadd("ZkHashtag", zk_hashtag_pattern, 200)
        end
      end)
    end
  end,
})
