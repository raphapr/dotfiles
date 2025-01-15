return {
  {
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup({
        save_path = vim.env.HOME .. "/Cloud/Sync/dooing_todos.json",
        keymaps = {
          toggle_window = "<leader>d",
          new_todo = "i",
          toggle_todo = "x",
          delete_todo = "d",
          delete_completed = "D",
          close_window = "q",
          undo_delete = "u",
          add_due_date = "H",
          remove_due_date = "r",
          toggle_help = "?",
          toggle_tags = "a",
          toggle_priority = "P",
          clear_filter = "c",
          edit_todo = "e",
          edit_tag = "e",
          edit_priorities = "p",
          delete_tag = "d",
          search_todos = "/",
          add_time_estimation = "T",
          remove_time_estimation = "R",
          import_todos = "I",
          export_todos = "E",
          remove_duplicates = "<leader>D",
          open_todo_scratchpad = "<leader>p",
        },
      })
    end,
  },
}
