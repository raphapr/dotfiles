return {
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
    cmd = { "G", "Git", "Gclog", "Gvdiffsplit" },
    keys = {
      { "<leader>tt", ":Git<CR>", silent = true, { desc = "git: summary window" } },
      { "<leader>tl", ":Gclog<CR>", silent = true, { desc = "git: log" } },
      { "<leader>tp", ":Git push ", silent = false, { desc = "git: push" } },
      { "<leader>td", ":Gvdiffsplit<CR>", silent = true, { desc = "git: diff split vertically" } },
    },
  },
}
