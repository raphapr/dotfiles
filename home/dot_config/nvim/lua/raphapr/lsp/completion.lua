local M = {}

local notebook_dir = vim.env.ZK_NOTEBOOK_DIR and vim.env.ZK_NOTEBOOK_DIR ~= "" and vim.fs.normalize(vim.fn.resolve(vim.env.ZK_NOTEBOOK_DIR))

-- `#` in zk notes starts a tag, not a GitHub issue.
local function outside_notebook()
  if not notebook_dir then
    return true
  end
  local path = vim.fs.normalize(vim.fn.resolve(vim.api.nvim_buf_get_name(0)))
  return not vim.startswith(path, notebook_dir .. "/")
end

local function has_words_before()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return col > 0 and not vim.api.nvim_get_current_line():sub(col, col):match("%s")
end

function M.setup()
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },
    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      documentation = { auto_show = true },
      menu = {
        draw = {
          -- Syntax colors on LSP labels; kind icons and colors from mini.icons.
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                return require("mini.icons").get("lsp", ctx.kind) .. ctx.icon_gap
              end,
              highlight = function(ctx)
                return select(2, require("mini.icons").get("lsp", ctx.kind))
              end,
            },
          },
        },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        markdown = { inherit_defaults = true, "linkc", "git" },
        gitcommit = { inherit_defaults = true, "git" },
      },
      providers = {
        -- Show buffer words next to LSP results, not only when LSP has none.
        lsp = { fallbacks = {} },
        buffer = { min_keyword_length = 3 },
        linkc = { name = "linkc", module = "raphapr.lsp.linkc" },
        git = { name = "Git", module = "blink-cmp-git", enabled = outside_notebook },
      },
    },
    cmdline = {
      completion = { menu = { auto_show = true } },
    },
  })
end

return M
