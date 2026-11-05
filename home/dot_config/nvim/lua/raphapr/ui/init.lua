-- Custom buffer tabline. The statusline is lualine (plugins/lualine.lua).
local tabline = require("raphapr.ui.tabline")

local function highlights()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if ok then
    tabline.highlights(palettes.get_palette())
  end
end

highlights()

local group = vim.api.nvim_create_augroup("RaphaprUi", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = highlights })

-- Neovim does not redraw the tabline when the buffer list changes. Schedule it:
-- a buffer is still listed while BufDelete runs.
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufWipeout", "BufModifiedSet", "BufFilePost" }, {
  group = group,
  callback = vim.schedule_wrap(function()
    vim.cmd.redrawtabline()
  end),
})

vim.o.tabline = "%!v:lua.require'raphapr.ui.tabline'.render()"
vim.o.showtabline = 2
vim.o.showmode = false -- the statusline shows the mode
