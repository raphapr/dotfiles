return {
  "Zeioth/hot-reload.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufEnter",
  opts = function()
    local config_dir = vim.fn.stdpath("config") .. "/lua/raphapr/"
    return {
      -- Files to be hot-reloaded when modified.
      reload_files = {
        config_dir .. "remaps.lua",
        config_dir .. "settings.lua",
        config_dir .. "utils.lua",
        config_dir .. "lazy.lua",
        config_dir .. "init.lua",
        config_dir .. "plugins/colorscheme.lua",
        config_dir .. "plugins/conform.lua",
        config_dir .. "plugins/copilot.lua",
        config_dir .. "plugins/git.lua",
        config_dir .. "plugins/go.lua",
        config_dir .. "plugins/grug-far.lua",
        config_dir .. "plugins/hot-reload.lua",
        config_dir .. "plugins/lsp.lua",
        config_dir .. "plugins/lualine.lua",
        config_dir .. "plugins/mini.lua",
        config_dir .. "plugins/misc.lua",
        config_dir .. "plugins/nvim-tree.lua",
        config_dir .. "plugins/obsidian.lua",
        config_dir .. "plugins/overseer.lua",
        config_dir .. "plugins/portal.lua",
        config_dir .. "plugins/telescope.lua",
        config_dir .. "plugins/treesitter.lua",
        config_dir .. "plugins/trouble.lua",
        config_dir .. "plugins/venv-selector.lua",
        config_dir .. "plugins/vim-base64.lua",
        config_dir .. "plugins/vim-zoom.lua",
        config_dir .. "plugins/multicursors.lua",
      },
      -- Things to do after hot-reload trigger.
      reload_callback = function()
        vim.cmd(":silent! doautocmd ColorScheme") -- heirline colorscheme reload event.
      end,
    }
  end,
}
