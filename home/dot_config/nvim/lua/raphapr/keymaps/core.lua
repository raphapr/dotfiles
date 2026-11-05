-- Basic editing and navigation keymaps

-- Move by visual lines unless an explicit count requests file lines.
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, noremap = true, desc = "move cursor down" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, noremap = true, desc = "move cursor up" })

-- move selected area up or down
vim.keymap.set("v", "K", [[:'<,'>move-2<cr>gv=gv]], { noremap = true, desc = "move selected area up" })
vim.keymap.set("v", "J", [[:'<,'>move'>+<cr>gv=gv]], { noremap = true, desc = "move selected area down" })

-- selected blocks are selected again before indentation
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "select block and indent left" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "select block and indent right" })

-- page up/down half a page and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "scroll down half a page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "scroll up half a page" })

-- Quickfix navigation
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true, desc = "jump to previous quickfix item" })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "jump to next quickfix item" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { silent = true, desc = "jump to first quickfix item" })
vim.keymap.set("n", "]Q", ":clast<CR>", { silent = true, desc = "jump to last quickfix item" })

-- Diagnostics and LSP lists in quickfix/loclist
local function toggle(list)
  local is_open = list == "c" and vim.fn.getqflist({ winid = 0 }).winid ~= 0 or list == "l" and vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
  vim.cmd(list .. (is_open and "close" or "open"))
end
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist, { desc = "Diagnostics: Workspace (quickfix)" })
vim.keymap.set("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Diagnostics: Buffer (loclist)" })
vim.keymap.set("n", "<leader>xs", function()
  vim.lsp.buf.document_symbol()
end, { desc = "Diagnostics: Symbols (loclist)" })
vim.keymap.set("n", "<leader>xl", function()
  vim.lsp.buf.references()
end, { desc = "Diagnostics: LSP references (quickfix)" })
vim.keymap.set("n", "<leader>xL", function()
  toggle("l")
end, { desc = "Diagnostics: Toggle location list" })
vim.keymap.set("n", "<leader>xq", function()
  toggle("c")
end, { desc = "Diagnostics: Toggle quickfix list" })

-- Copy/paste with system clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Clipboard: Copy to system clipboard" })
vim.keymap.set(
  { "n", "x" },
  "gY",
  '"+y$',
  { desc = "Clipboard: Copy to system clipboard without the new line at the end" }
)
vim.keymap.set("n", "gp", '"+p', { desc = "Clipboard: Paste from system clipboard" })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set("x", "gp", '"+P', { desc = "Clipboard: Paste from system clipboard" })
