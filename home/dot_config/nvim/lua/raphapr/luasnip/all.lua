-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function clipboard()
  return vim.fn.getreg("+")
end

local snippets = {}

return {

  -- Paste clipboard contents in markdown link section, then move cursor to ()
  table.insert(
    snippets,
    s({
      trig = "linkc",
      name = "Paste clipboard as .md link",
      desc = "Paste clipboard as .md link",
    }, {
      t("["),
      i(1),
      t("]("),
      f(clipboard, {}),
      t(")"),
    })
  ),

  ls.add_snippets("markdown", snippets),
}
