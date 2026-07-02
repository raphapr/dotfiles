-- Parsers beyond nvim's bundled ones (lua, vim, vimdoc, c, markdown)
local ensure_installed = {
  "bash",
  "dockerfile",
  "fish",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "hcl",
  "helm",
  "javascript",
  "json",
  "markdown_inline",
  "python",
  "terraform",
  "toml",
  "typescript",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSUninstall" },
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()
      ts.install(ensure_installed)

      -- The main branch does not enable highlighting by itself;
      -- start treesitter when a parser is available for the filetype
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(event.buf, lang)
          end
        end,
      })
    end,
  },
}
