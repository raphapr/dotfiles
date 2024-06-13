return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = "GrugFar",
    config = function()
      require('grug-far').setup()
    end,
    keys = {
      { "<leader>f", "<cmd>GrugFar<CR>", desc = "Find and Replace" },
    },
  }
}
