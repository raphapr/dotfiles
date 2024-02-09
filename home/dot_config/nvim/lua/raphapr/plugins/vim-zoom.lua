return {
  {
    "dhruvasagar/vim-zoom",
    keys = {
      {
        "=",
        ":call zoom#toggle()<CR>",
        silent = true,
        { noremap = true, desc = "toggle zoom of the current window." },
      },
    },
  },
}
