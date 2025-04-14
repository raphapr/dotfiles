return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  lazy = false,
  config = function()
    require("mcphub").setup({
      config = vim.fn.expand("~/.mcpservers.json"),
      auto_approve = true,
      extensions = {
        codecompanion = {
          show_result_in_chat = true, -- show the mcp tool result in the chat buffer
          make_vars = true, -- make chat #variables from MCP server resources
          make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
      },
    })
  end,
}
