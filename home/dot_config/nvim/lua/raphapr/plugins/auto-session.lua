return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>fp", "<cmd>AutoSession search<CR>", desc = "Find: Projects (sessions)" },
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session: Search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Session: Save" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Session: Toggle autosave" },
    { "<leader>wd", "<cmd>AutoSession delete<CR>", desc = "Session: Delete" },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
    -- Picker display hook: `repo` for plain dirs, `repo:branch` for `<repo>__worktrees/<branch>`.
    -- Fuzzy match still uses the full path, so typing part of the path finds it.
    require("auto-session.lib").shorten_path = function(path)
      local repo, wt = path:match("([^/]+)__worktrees/([^/]+)$")
      return repo and (repo .. ":" .. wt) or vim.fn.fnamemodify(path, ":t")
    end
  end,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "/", "/tmp" },
    cwd_change_handling = true, -- :cd (or zoxide picker) saves current session, wipes buffers, restores target
    lsp_stop_on_restore = true,
    -- Runs after the old session is saved. Without it buffers leak into a project that has no session yet.
    pre_cwd_changed_cmds = { "silent! %bw!" },
  },
}
