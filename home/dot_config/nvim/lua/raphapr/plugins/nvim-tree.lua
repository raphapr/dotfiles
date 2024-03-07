return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = { "NvimTreeToggle" },
    keys = {
      { "<F10>", ":NvimTreeToggle<cr>" },
    },
    config = function()
      local function open_tab_silent(node)
        local api = require("nvim-tree.api")
        api.node.open.tab(node)
        vim.cmd.tabprev()
      end

      local function nvim_tree_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "T", open_tab_silent, opts("Open Tab Silent"))
      end

      -- setup with some options
      require("nvim-tree").setup({
        on_attach = nvim_tree_on_attach,
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
        },
        actions = {
          change_dir = {
            enable = true,
            global = true,
          },
        },
      })
    end,
  },
}
