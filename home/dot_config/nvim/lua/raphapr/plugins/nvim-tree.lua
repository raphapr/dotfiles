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

        local git_add = function()
          local node = api.tree.get_node_under_cursor()
          local gs = node.git_status.file

          -- If the current node is a directory get children status
          if gs == nil then
            gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
              or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
          end

          -- If the file is untracked, unstaged or partially staged, we stage it
          if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
            vim.cmd("silent !git add " .. node.absolute_path)

            -- If the file is staged, we unstage
          elseif gs == "M " or gs == "A " then
            vim.cmd("silent !git restore --staged " .. node.absolute_path)
          end

          api.tree.reload()
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "ga", git_add, opts("Git Add"))
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
        sync_root_with_cwd = true,
      })
    end,
  },
}
