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

-- Set highlight for Zk hashtags in markdown files within the ZK_NOTEBOOK_DIR
local zk_hashtag_group = vim.api.nvim_create_augroup("ZkHashtagHighlight", { clear = true })
local zk_hashtag_pattern = [[\v(^|[[:space:]\[({])\zs#[A-Za-z][A-Za-z0-9_/-]*]]

local function resolved_path(path)
  if not path or path == "" then
    return ""
  end

  return vim.fs.normalize(vim.fn.resolve(vim.fn.fnamemodify(path, ":p"))):gsub("/$", "")
end

vim.api.nvim_create_autocmd("FileType", {
  group = zk_hashtag_group,
  pattern = "markdown",
  callback = function()
    local notebook_dir = resolved_path(vim.env.ZK_NOTEBOOK_DIR)
    local buffer_path = resolved_path(vim.api.nvim_buf_get_name(0))
    if notebook_dir == "" or not vim.startswith(buffer_path, notebook_dir .. "/") then
      return
    end

    vim.cmd("syntax match Identifier @" .. zk_hashtag_pattern .. "@ containedin=ALL")
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

