return {
  {
    "christianrondeau/vim-base64",
    init = function()
      vim.g.vim_base64_disable_default_key_mappings = 1
    end,
    keys = {
      { "<leader>bd", ":<c-u>call base64#v_atob()<cr>", mode = "v", silent = true, desc = "Base64: Decode selected base64-encoded text." },
      { "<leader>be", ":<c-u>call base64#v_btoa()<cr>", mode = "v", silent = true, desc = "Base64: Encode selected text as base64." },
    },
  },
}
