require("catppuccin").setup({
  flavour = "mocha",
  -- Borderless floats: a mantle panel instead of border lines.
  float = { solid = true },
  -- Fade windows without the cursor, so the active split stands out.
  dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
  integrations = {
    blink_cmp = true,
    flash = true,
    gitsigns = true,
    markdown = true,
    render_markdown = true,
    mini = { enabled = true },
  },
  custom_highlights = function(c)
    -- Solid floats default to mantle, which nearly matches dimmed windows
    -- (dim_inactive). A raised panel between base and surface0 stands out
    -- against both normal and dimmed windows.
    local raised = require("catppuccin.utils.colors").blend(c.surface0, c.base, 0.5)
    return {
      NormalFloat = { fg = c.text, bg = raised },
      FloatBorder = { fg = raised, bg = raised },
      FloatTitle = { fg = c.subtext0, bg = raised },
      Pmenu = { fg = c.overlay2, bg = raised },
      PmenuBorder = { fg = raised, bg = raised },
      BlinkCmpMenuBorder = { fg = raised, bg = raised },
      -- Pickers: plain name and count, a mauve prompt, bold yellow matched
      -- letters and a selected row that stands out on the raised panel.
      MiniPickBorderText = { fg = c.overlay1, bg = raised },
      MiniPickPrompt = { fg = c.text, bg = raised },
      MiniPickPromptPrefix = { fg = c.mauve, bg = raised, style = { "bold" } },
      MiniPickPromptCaret = { fg = c.mauve, bg = raised },
      MiniPickMatchRanges = { fg = c.yellow, style = { "bold" } },
      MiniPickMatchCurrent = { fg = c.text, bg = c.surface1, style = { "bold" } },
    }
  end,
})
vim.cmd.colorscheme("catppuccin")
