return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  lazy = false, -- Load immediately so keymaps are available
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
        },
        terminal = {},
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = "tmux",
      events = {
        reload = true,
      },
    }

    -- Keymaps

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "OpenCode: Ask with context" })

    vim.keymap.set({ "n", "x" }, "<leader>oc", function()
      require("opencode").ask("", { submit = false })
    end, { desc = "OpenCode: Ask (custom prompt)" })

    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      require("opencode").select()
    end, { desc = "OpenCode: Execute action" })

    -- OpenCode operators (go* pattern - extends gy/gp)
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "OpenCode: Add range to context", expr = true })

    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "OpenCode: Add line to context", expr = true })

    vim.keymap.set("n", "<leader>os", function()
      require("opencode").select_server()
    end, { desc = "OpenCode: Select server" })
  end,
}
