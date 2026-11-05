-- Buffer tabline with slanted separators, scrolled to keep the current buffer visible.
local M = {}

local SEP_LEFT, SEP_RIGHT = "\u{e0ba}", "\u{e0b8}"
local MAX_NAME = 24

function M.highlights(c)
  local hl = function(name, spec)
    vim.api.nvim_set_hl(0, name, spec)
  end
  hl("TabLineFill", { bg = c.mantle })
  hl("TabLineActive", { fg = c.crust, bg = c.blue, bold = true })
  hl("TabLineActiveSep", { fg = c.blue, bg = c.mantle })
  hl("TabLineActiveModified", { fg = c.crust, bg = c.peach, bold = true })
  hl("TabLineActiveModifiedSep", { fg = c.peach, bg = c.mantle })
  hl("TabLineInactive", { fg = c.subtext0, bg = c.surface0 })
  hl("TabLineInactiveSep", { fg = c.surface0, bg = c.mantle })
  hl("TabLineInactiveModified", { fg = c.peach, bg = c.surface0 })
  hl("TabLineTabs", { fg = c.crust, bg = c.mauve, bold = true })
  hl("TabLineTabsSep", { fg = c.mauve, bg = c.mantle })
end

local function label(buf, duplicated)
  local name = vim.api.nvim_buf_get_name(buf)
  if vim.bo[buf].buftype == "terminal" then
    return "\u{f489} Terminal"
  elseif name == "" then
    return "[No Name]"
  end

  local file = vim.fs.basename(name)
  -- Prefix the parent directory when several buffers share a file name.
  local text = duplicated[file] and (vim.fs.basename(vim.fs.dirname(name)) .. "/" .. file) or file
  if vim.fn.strchars(text) > MAX_NAME then
    text = "…" .. vim.fn.strcharpart(text, vim.fn.strchars(text) - MAX_NAME + 1)
  end
  return MiniIcons.get("file", file) .. " " .. text
end

local function segment(buf, current, duplicated)
  local kind = buf == current and "Active" or "Inactive"
  local modified = vim.bo[buf].modified
  local body_hl = "TabLine" .. kind .. ((modified and kind == "Active") and "Modified" or "")
  local text = " " .. label(buf, duplicated) .. (modified and " ●" or "") .. " "
  local sep = "%#" .. body_hl .. "Sep#"
  if kind == "Inactive" then
    body_hl = modified and "TabLineInactiveModified" or "TabLineInactive"
    sep = "%#TabLineInactiveSep#"
  end
  return {
    text = sep .. SEP_LEFT .. "%#" .. body_hl .. "#" .. text:gsub("%%", "%%%%") .. sep .. SEP_RIGHT,
    width = vim.api.nvim_strwidth(text) + 2,
  }
end

function M.render()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.tbl_filter(function(buf)
    return vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  local seen, duplicated = {}, {}
  for _, buf in ipairs(bufs) do
    local file = vim.fs.basename(vim.api.nvim_buf_get_name(buf))
    duplicated[file] = seen[file] or nil
    seen[file] = true
  end

  local tabs = ""
  local tabs_width = 0
  local tab_count = vim.fn.tabpagenr("$")
  if tab_count > 1 then
    local text = (" TAB %d/%d "):format(vim.fn.tabpagenr(), tab_count)
    tabs = "%#TabLineTabsSep#" .. SEP_LEFT .. "%#TabLineTabs#" .. text
    tabs_width = vim.api.nvim_strwidth(text) + 1
  end

  local segments, current_index = {}, 1
  for i, buf in ipairs(bufs) do
    segments[i] = segment(buf, current, duplicated)
    if buf == current then
      current_index = i
    end
  end

  -- Grow a window of segments around the current buffer until the line is full.
  local available = vim.o.columns - tabs_width
  local first, last = current_index, current_index
  local used = segments[current_index] and segments[current_index].width or 0
  while true do
    local grew = false
    if last < #segments and used + segments[last + 1].width <= available then
      last, used, grew = last + 1, used + segments[last + 1].width, true
    end
    if first > 1 and used + segments[first - 1].width <= available then
      first, used, grew = first - 1, used + segments[first - 1].width, true
    end
    if not grew then
      break
    end
  end

  local parts = {}
  for i = first, last do
    parts[#parts + 1] = segments[i] and segments[i].text or ""
  end
  return table.concat(parts) .. "%#TabLineFill#%=" .. tabs
end

return M
