return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = {
        enabled = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
    { "<leader>mf", mode = { "n" }, function() require("flash").toggle() end, desc = "Misc: Toggle Flash Search" },
  },
}
