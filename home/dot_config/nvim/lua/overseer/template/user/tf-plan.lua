return {
  name = "terraform plan",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "plan" },
      components = { { "on_output_quickfix", open = true, tail = true }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
