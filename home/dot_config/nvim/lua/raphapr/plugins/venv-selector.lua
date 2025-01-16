return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --both are optionals for debugging
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = true,
  cmd = "VenvSelect",
  keys = {
    { "<leader>ve", "<cmd>VenvSelect<cr>" },
  },
  branch = "regexp", -- This is the regexp branch, use this for the new version
  config = function()
    local function shorter_name(filename)
      return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
    end
    require("venv-selector").setup({
      settings = {
        options = {
          enable_default_searches = false,
          on_telescope_result_callback = shorter_name,
        },
        search = {
          venvs = {
            command = "fd -t f 'bin/python$' ~/.virtualenvs --full-path -IHL", -- Sample command, need to be changed for your own venvs
            on_telescope_result_callback = shorter_name,
          },
        },
      },
    })
  end,
}
