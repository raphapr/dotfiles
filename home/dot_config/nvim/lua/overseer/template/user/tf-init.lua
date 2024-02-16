return {
  name = "terraform init",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "init", "-upgrade" },
      components = { { "on_complete_notify" }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
