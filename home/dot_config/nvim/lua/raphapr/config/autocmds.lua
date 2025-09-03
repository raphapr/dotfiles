-- YAML file settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    -- Use 2-space indentation for YAML
    vim.api.nvim_command("setlocal ts=2 sts=2 sw=2 expandtab")
    -- Highlight tabs as errors
    vim.api.nvim_command("match Error /\\t/")
  end,
})

-- jump to the last place you’ve visited in a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight yank region
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- Disable diagnostic virtual/underline text when in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("tiny-inline-diagnostic").disable()
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    require("tiny-inline-diagnostic").enable()
  end,
})

-- Set formatprg to jq for json files (rest.nvim)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
  end,
})
