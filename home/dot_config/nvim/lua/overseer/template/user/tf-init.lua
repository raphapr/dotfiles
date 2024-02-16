return {
  name = "terraform init",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "init", "-upgrade" },
      components = { { "on_output_quickfix", open_on_exit = "failure", tail = true }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
