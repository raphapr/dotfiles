-------------------------------------- gitsigns ---------------------------------------
require("gitsigns").setup({
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
})

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Git: Toggle current line blame" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<CR>", { desc = "Git: Preview hunk inline" })
vim.keymap.set("n", "<leader>ga", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Git: Stage hunk" })
vim.keymap.set("x", "<leader>ga", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Git: Stage selected lines" })

-------------------------------------- codediff ---------------------------------------
-- review.nvim opens its reviews in codediff, so these settings apply there.
require("codediff").setup({
  explorer = {
    width = 50,
    view_mode = "tree",
    auto_open_on_cursor = true, -- j/k in the explorer opens the file under the cursor
    line_stats = { enabled = true },
  },
  diff = {
    layout = "inline", -- toggle side-by-side with t
    compact = true, -- fold unchanged code; toggle with gc
    compact_context_lines = 8,
    compact_sync_folds = true,
  },
})

-- review.nvim has no history view; codediff keeps these.
vim.keymap.set("n", "<leader>gh", "<cmd>CodeDiff history %<CR>", { desc = "Git: File history" })
vim.keymap.set("n", "<leader>gH", "<cmd>CodeDiff history<CR>", { desc = "Git: Repo history" })

-------------------------------------- review -----------------------------------------
-- Comment on diffs and export the review as markdown for an agent (C copies it).
require("review").setup({})

vim.keymap.set("n", "<leader>rr", "<cmd>Review<CR>", { desc = "Review: Working tree" })
vim.keymap.set("n", "<leader>rb", "<cmd>Review branch<CR>", { desc = "Review: Branch" })
vim.keymap.set("n", "<leader>rc", "<cmd>Review commits<CR>", { desc = "Review: Commits" })
-- `:` instead of <Cmd> so visual mode passes the '<,'> range.
vim.keymap.set({ "n", "x" }, "<leader>rn", ":Review note<CR>", { silent = true, desc = "Review: Note here" })
vim.keymap.set("n", "<leader>re", "<cmd>Review edit<CR>", { desc = "Review: Edit comment" })
vim.keymap.set("n", "<leader>rd", "<cmd>Review delete<CR>", { desc = "Review: Delete comment" })
vim.keymap.set("n", "<leader>rl", "<cmd>Review list<CR>", { desc = "Review: List comments" })
vim.keymap.set("n", "<leader>rx", "<cmd>Review export<CR>", { desc = "Review: Export to clipboard" })
