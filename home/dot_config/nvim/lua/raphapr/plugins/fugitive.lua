return {
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
    cmd = { "G", "Git", "Gclog", "Gvdiffsplit" },
    keys = {
      { "<leader>tb", ":Git blame<CR>", silent = true, { desc = "git: summary window" } },
    },
  },
}
