-- Checkmate adds notebook task states while keeping plain Markdown on disk.
return {
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {
      -- Matches root and nested notes through both ~/Cloud and resolved ~/Dropbox paths.
      files = { "**/Sync/notebook/*.md", "**/Sync/notebook/**/*.md" },
      keys = {
        ["<leader>tt"] = { rhs = "<cmd>Checkmate toggle<CR>", desc = "Tasks: Toggle", modes = { "n", "v" } },
        ["<leader>tc"] = { rhs = "<cmd>Checkmate check<CR>", desc = "Tasks: Mark done", modes = { "n", "v" } },
        ["<leader>tu"] = { rhs = "<cmd>Checkmate uncheck<CR>", desc = "Tasks: Mark pending", modes = { "n", "v" } },
        ["<leader>t="] = { rhs = "<cmd>Checkmate cycle_next<CR>", desc = "Tasks: Next state", modes = { "n", "v" } },
        ["<leader>t-"] = { rhs = "<cmd>Checkmate cycle_previous<CR>", desc = "Tasks: Previous state", modes = { "n", "v" } },
      },
      metadata = { priority = {}, started = {}, done = {} },
      -- [ ] pending, [-] in progress, [x] done, [/] cancelled.
      todo_states = {
        unchecked = { marker = "󰄱", order = 1 },
        in_progress = { marker = "󰡖", markdown = "-", type = "incomplete", order = 2 },
        checked = { marker = "󰄲", order = 3 },
        cancelled = { marker = "󰅗", markdown = "/", type = "complete", order = 4 },
      },
    },
  },
}
