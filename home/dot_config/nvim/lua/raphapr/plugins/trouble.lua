return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end,
      { desc = "Trouble: Toggle diagnostics" })
    vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
      { desc = "Trouble: Workspace diagnostics" })
    vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
      { desc = "Trouble: Document diagnostics" })
    vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("Quickfix") end,
      { desc = "Trouble: quickfix" })
    vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Trouble: loclist" })
  end,
  opts = {
    action_keys = {                                -- key mappings for actions in the trouble list
      close = "q",                                 -- close the list
      cancel = "<esc>",                            -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r",                               -- manually refresh
      jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" },                    -- open buffer in new split
      open_vsplit = { "<c-v>" },                   -- open buffer in new vsplit
      open_tab = { "<c-t>" },                      -- open buffer in new tab
      jump_close = { "o" },                        -- jump to the diagnostic and close the list
      toggle_mode = "m",                           -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = "s",                       -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
      toggle_preview = "P",                        -- toggle auto_preview
      hover = "K",                                 -- opens a small popup with the full multiline message
      preview = "p",                               -- preview the diagnostic location
      open_code_href = "c",                        -- if present, open a URI with more information about the diagnostic error
      close_folds = { "zM", "zm" },                -- close all folds
      open_folds = { "zR", "zr" },                 -- open all folds
      toggle_fold = { "zA", "za" },                -- toggle fold of current file
      previous = "k",                              -- previous item
      next = "j",                                  -- next item
      help = "?",                                  -- help menu
    },
  },
}
