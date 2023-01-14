vim.g.did_load_filetypes = 1
require("filetype").setup {
  overrides = {
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      tfstate = "json",
      fish = "fish",
    },
  },
}
