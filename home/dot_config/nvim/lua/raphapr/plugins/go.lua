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
    lazy = true,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      { "godb", ":GoDebug<CR>",      noremap = true, desc = "Go: Start delve for debugging" },
      { "gof",  ":GoFillStruct<CR>", noremap = true, desc = "Go: Fill struct in Go" },
      { "gom",  ":GoModTidy<CR>",    noremap = true, desc = "Go: Run go mod tidy and restart lsp" },
    },
    config = function()
      require("go").setup()
      vim.api.nvim_create_user_command("GoModTidy", function()
        vim.cmd.write()
        vim.cmd("!go mod tidy -v")
        vim.cmd.LspRestart()
        vim.notify("go mod tidy finished")
      end, {})
    end,
  },
}
