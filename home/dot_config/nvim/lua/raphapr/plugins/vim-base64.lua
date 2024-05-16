return {
  {
    "christianrondeau/vim-base64",
    init = function()
      vim.g.vim_base64_disable_default_key_mappings = 1
    end,
    config = function()
      vim.keymap.set(
        "v",
        "<leader>bd",
        ":<c-u>call base64#v_atob()<cr>",
        { noremap = true, silent = true, desc = "Base64: Decode selected base64-encoded text." }
      )
      vim.keymap.set(
        "v",
        "<leader>be",
        ":<c-u>call base64#v_btoa()<cr>",
        { noremap = true, silent = true, desc = "Base64: Encode selected text as base64." }
      )
    end,
  },
}
