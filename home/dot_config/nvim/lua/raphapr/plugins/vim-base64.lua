-- Read when the plugin's plugin/ script is sourced after init.lua.
vim.g.vim_base64_disable_default_key_mappings = 1

vim.keymap.set("v", "<leader>bd", ":<c-u>call base64#v_atob()<cr>", { silent = true, desc = "Base64: Decode selected base64-encoded text." })
vim.keymap.set("v", "<leader>be", ":<c-u>call base64#v_btoa()<cr>", { silent = true, desc = "Base64: Encode selected text as base64." })
