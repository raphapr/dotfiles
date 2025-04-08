-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function clipboard()
  local content = vim.fn.getreg("+")
  local pr_number = content:match("https://github.com/.+/pull/(%d+)")
  local jira_key = content:match("https://.+.atlassian.net/browse/([A-Z]+%-%d+)")
  if pr_number then
    return "#" .. pr_number
  elseif jira_key then
    return jira_key
  else
    return nil
  end
end

local snippets = {}

table.insert(
  snippets,
  s({
    trig = "linkc",
    name = "Paste clipboard as .md link",
    desc = "Paste clipboard as .md link",
  }, {
    t("["),
    f(function()
      local result = clipboard()
      if result then
        return result
      else
        return ""
      end
    end, {}),
    i(1),
    t("]("),
    f(function()
      return vim.fn.getreg("+")
    end, {}),
    t(")"),
  })
)

ls.add_snippets("markdown", snippets)

return snippets
