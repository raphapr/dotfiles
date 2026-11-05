-- blink.cmp source for markdown: `linkc` pastes the clipboard URL as a link,
-- labelled `#123` for GitHub PRs or `KEY-1` for Jira issues.
local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:get_completions(_, callback)
  callback({
    items = {
      {
        label = "linkc",
        kind = require("blink.cmp.types").CompletionItemKind.Snippet,
        documentation = "Paste clipboard as .md link",
      },
    },
    is_incomplete_backward = false,
    is_incomplete_forward = false,
  })
end

local function escape(text)
  return (text:gsub("[%$}\\]", "\\%0"))
end

-- Read the clipboard only on accept: getreg("+") spawns the clipboard tool.
function source:execute(ctx, _, callback)
  local url = vim.trim(vim.fn.getreg("+"))
  local pr = url:match("https://github%.com/.+/pull/(%d+)")
  local label = pr and ("#" .. pr) or url:match("https://.+%.atlassian%.net/browse/([A-Z]+%-%d+)") or ""

  local row = ctx.bounds.line_number - 1
  local start = ctx.bounds.start_col - 1
  vim.api.nvim_buf_set_text(0, row, start, row, start + ctx.bounds.length, { "" })
  vim.api.nvim_win_set_cursor(0, { row + 1, start })
  vim.snippet.expand("[" .. escape(label) .. "${1}](" .. escape(url) .. ")")
  callback()
end

return source
