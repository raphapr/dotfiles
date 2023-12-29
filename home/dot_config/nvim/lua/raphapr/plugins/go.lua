return {

  -- go.nvim
  -- DAP UI keymaps
  -- c	continue
  -- n	next
  -- s	step
  -- o	stepout
  -- S	cap S: stop debug
  -- u	up
  -- D	cap D: down
  -- C	cap C: run to cursor
  -- b	toggle breakpoint
  -- P	cap P: pause
  -- p	print, hover value (also in visual mode)

  {
    "ray-x/go.nvim",
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    config = function()
      require("go").setup()

      vim.api.nvim_create_user_command("GoModTidy", function()
        vim.cmd.write()
        vim.cmd("!go mod tidy -v")
        vim.cmd.LspRestart()
        vim.notify("go mod tidy finished")
      end, {})

      vim.keymap.set("n", "<leader>db", ":GoDebug<CR>", { noremap = true, desc = "Start delve for debugging" })
      vim.keymap.set("n", "<leader>fs", ":GoFillStruct<CR>", { noremap = true, desc = "Fill struct in Go" })
      vim.keymap.set("n", "<leader>gm", ":GoModTidy<CR>", { noremap = true, desc = "Run go mod tidy and restart lsp" })
    end,
  },
}
