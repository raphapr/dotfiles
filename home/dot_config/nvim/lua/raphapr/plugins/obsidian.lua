return {
  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "VeryLazy" },
    version = "*", -- recommended, use latest release instead of latest commit
    opts = {
      dir = "~/Cloud/Vaults/Raphakasten",
      notes_subdir = "Zettels",
      daily_notes = {
        folder = "Daily",
        date_format = "%d-%m-%Y",
        template = "_Templates/daily.md",
      },
      templates = {
        subdir = "_Templates",
        date_format = "%d/%m/%Y",
        time_format = "%H:%M",
      },
      disable_frontmatter = true,
      note_id_func = function(title)
        local filename = ""
        if title ~= nil then
          filename = title
        else
          for _ = 1, 4 do
            filename = filename .. string.char(math.random(65, 90))
          end
        end
        return filename
      end,
    },
    keys = {
      { "<leader>on", ":ObsidianNew ", desc = "obsidian: New Note" },
      { "<leader>ot", ":ObsidianTemplate<CR>", desc = "obsidian: Template" },
      { "<leader>oq", ":ObsidianQuickSwitch<CR>", desc = "obsidian: Quick Switcher" },
      { "<leader>os", ":ObsidianSearch<CR>", desc = "obsidian: Search" },
      { "<leader>od", ":ObsidianToday<CR>", desc = "obsidian: Daily" },
    },
  },
}
