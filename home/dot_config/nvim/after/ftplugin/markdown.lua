-- Built-in gx falls back to <cfile> when the cursor is not on a link, so on a
-- list bullet, checkbox, or heading mark it runs `xdg-open -` and fails. Open
-- the http link under the cursor; on punctuation, the line's first link.
-- Read the global map: maparg would return this buffer map after `:e`, and recurse.
local default_gx
for _, map in ipairs(vim.api.nvim_get_keymap("n")) do
  if map.lhs == "gx" then
    default_gx = map.callback
  end
end

vim.keymap.set("n", "gx", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local links = {}
  -- [text](url) and [text](<url>) spans, so the cursor on the text opens its URL.
  for _, pat in ipairs({
    "()%[[^%]]*%]%(<(https?://[^>]+)>%)()",
    "()%[[^%]]*%]%((https?://[^%s)]+)%)()",
    "()(https?://[^%s)>]+)()",
  }) do
    for s, url, e in line:gmatch(pat) do
      links[#links + 1] = { s = s, e = e, url = url }
    end
  end
  table.sort(links, function(a, b)
    return a.s < b.s
  end)
  for _, l in ipairs(links) do
    if col >= l.s and col < l.e then
      return vim.ui.open(l.url)
    end
  end
  if not vim.fn.expand("<cfile>"):match("^%p*$") then
    return default_gx()
  end
  if links[1] then
    vim.ui.open(links[1].url)
  else
    vim.notify("No link on this line", vim.log.levels.WARN)
  end
end, { buffer = true, desc = "Open link under cursor or on line" })
