return {
  "sotte/presenting.nvim",
  cmd = { "Presenting" },
  keys = {
    {
      "<leader>mp",
      "<cmd>Presenting<cr>",
      desc = "Misc: Start presentation",
      silent = true,
    },
  },
  opts = {
    options = {
      width = 150,
    },
    parse_frontmatter = true,
    keymaps = {
      ["j"] = function()
        Presenting.next()
      end,
      ["k"] = function()
        Presenting.prev()
      end,
      ["<Right>"] = function()
        Presenting.next()
      end,
      ["<Left>"] = function()
        Presenting.prev()
      end,
    },
  },
}
