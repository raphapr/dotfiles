require("filetype").setup({
  overrides = {
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      tfstate = "json",
      fish = "fish",
    },
  },
})
