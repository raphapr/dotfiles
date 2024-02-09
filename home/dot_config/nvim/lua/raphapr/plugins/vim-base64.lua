return {
  {
    "christianrondeau/vim-base64",
    config = function()
      vim.keymap.set(
        "v",
        "<leader>de",
        ":<c-u>call base64#v_atob()<cr>",
        { noremap = true, silent = true, desc = "decode selected base64-encoded text." }
      )
      vim.keymap.set(
        "v",
        "<leader>en",
        ":<c-u>call base64#v_btoa()<cr>",
        { noremap = true, silent = true, desc = "encode selected text as base64." }
      )
    end,
  },
}
