require("obsidian").setup({
  dir = "~/Cloud/Vaults/Raphakasten",
  notes_subdir = "Zettels",
  daily_notes = {
    folder = "Daily",
    date_format = "%d/%m/%Y",
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
})

vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "Obsidian New Note" })
vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>", { desc = "Obsidian Template" })
vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switcher" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian Search" })
