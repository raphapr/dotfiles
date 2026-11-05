-- Slanted blocks with gaps that match the custom tabline (lua/raphapr/ui/tabline.lua).
-- Based on lualine's examples/slanted-gaps.lua.
local palette = require("catppuccin.palettes").get_palette()

-- catppuccin's theme with the middle (section c, and the gaps) in the editor
-- background, so the blocks float on the buffer color.
local theme = vim.deepcopy(require("lualine.themes.catppuccin-nvim"))
for _, mode in pairs(theme) do
  if mode.c then
    mode.c.bg = palette.base
  end
end

-- Draws nothing but its separators: the gap between two blocks.
local gap = require("lualine.component"):extend()
function gap:draw(default_highlight)
  self.status = ""
  self.applied_separator = ""
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Give every component its own slanted edges and put a gap after each one.
local function with_gaps(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < "x"
    for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
      table.insert(section, pos * 2, { gap, color = { fg = palette.base, bg = palette.base } })
    end
    for id, component in ipairs(section) do
      if type(component) ~= "table" then
        component = { component }
        section[id] = component
      end
      component.separator = left and { right = "\u{e0bc}" } or { left = "\u{e0ba}" }
    end
  end
  return sections
end

-- Path relative to cwd: directory dimmed, file name bold (peach when modified).
local function pretty_path(self)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return "[No Name]"
  end
  local relative = vim.fn.fnamemodify(name, ":~:.")
  local dir, file = relative:match("^(.*/)([^/]*)$")
  local escape = function(text)
    return (text:gsub("%%", "%%%%"))
  end
  local default = self:get_default_hl()
  local modified = vim.bo.modified
  local result = "%#LualinePathDir#"
    .. escape(dir or "")
    .. (modified and "%#LualinePathModified#" or "%#LualinePathFile#")
    .. escape(file or relative)
    .. (modified and " ●" or "")
    .. default
  if vim.bo.readonly or not vim.bo.modifiable then
    result = result .. " \u{f033e}"
  end
  return result
end

local function set_path_highlights()
  local c = require("catppuccin.palettes").get_palette()
  vim.api.nvim_set_hl(0, "LualinePathDir", { fg = c.overlay1, bg = c.base })
  vim.api.nvim_set_hl(0, "LualinePathFile", { fg = c.text, bg = c.base, bold = true })
  vim.api.nvim_set_hl(0, "LualinePathModified", { fg = c.peach, bg = c.base, bold = true })
end
set_path_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("LualinePath", { clear = true }),
  callback = set_path_highlights,
})

local macro = {
  function()
    return "\u{f044b} " .. vim.fn.reg_recording()
  end,
  cond = function()
    return vim.fn.reg_recording() ~= ""
  end,
  color = { fg = palette.red, gui = "bold" },
}

local lsp_progress = {
  function()
    local ok, status = pcall(vim.ui.progress_status)
    return ok and status or ""
  end,
}

local venv = {
  function()
    return "venv:" .. vim.fs.basename(vim.env.VIRTUAL_ENV)
  end,
  cond = function()
    return vim.env.VIRTUAL_ENV ~= nil and vim.env.VIRTUAL_ENV ~= ""
  end,
}

require("lualine").setup({
  options = {
    theme = theme,
    section_separators = { left = "\u{e0bc}", right = "\u{e0ba}" },
    component_separators = { left = "", right = "" },
    refresh = {
      -- Defaults plus the events that change macro, diagnostics and progress.
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "SessionLoadPost",
        "FileChangedShellPost",
        "VimResized",
        "Filetype",
        "CursorMoved",
        "CursorMovedI",
        "ModeChanged",
        "RecordingEnter",
        "RecordingLeave",
        "DiagnosticChanged",
        "LspProgress",
      },
    },
  },
  sections = with_gaps({
    lualine_a = { "mode" },
    lualine_b = { { "branch", icon = "\u{e0a0}" } },
    lualine_c = { pretty_path },
    lualine_x = {
      macro,
      lsp_progress,
      venv,
      {
        "diagnostics",
        symbols = { error = "\u{f057} ", warn = "\u{f071} ", info = "\u{f05a} ", hint = "\u{f0eb} " },
      },
      {
        "diff",
        symbols = { added = "\u{f0fe} ", modified = "\u{f14b} ", removed = "\u{f146} " },
        diff_color = {
          added = { fg = palette.green },
          modified = { fg = palette.yellow },
          removed = { fg = palette.red },
        },
        source = function()
          local status = vim.b.gitsigns_status_dict
          if status then
            return { added = status.added, modified = status.changed, removed = status.removed }
          end
        end,
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  }),
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "quickfix", "nvim-tree" },
})
