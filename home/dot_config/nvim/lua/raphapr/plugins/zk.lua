return {
  {
    "zk-org/zk-nvim",
    lazy = false,
    config = function()
      require("zk").setup({
        picker = "telescope",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
          on_attach = function(client, bufnr)
            -- Scope to zk's namespace; a global config() would disable
            -- signs/underline for every LSP in the session
            vim.diagnostic.config({ signs = false, underline = false }, vim.lsp.diagnostic.get_namespace(client.id))
          end,
        },
      })
      local map = vim.api.nvim_set_keymap
      local function opts(desc)
        return { noremap = true, silent = true, desc = "zk: " .. desc }
      end

      local function open_daily_note()
        local command = { "zk" }
        if vim.env.ZK_NOTEBOOK_DIR and vim.env.ZK_NOTEBOOK_DIR ~= "" then
          vim.list_extend(command, { "--notebook-dir", vim.env.ZK_NOTEBOOK_DIR, "-W", vim.env.ZK_NOTEBOOK_DIR })
        end
        vim.list_extend(command, { "new", "--no-input", "--print-path", "--date", os.date("%Y-%m-%d"), "journal/daily" })

        local output = vim.fn.systemlist(command)
        if vim.v.shell_error ~= 0 or not output[1] or output[1] == "" then
          vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR)
          return false
        end

        local note_path = vim.fn.fnamemodify(output[1], ":p")
        local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
        if note_path ~= current_path then
          vim.cmd.edit(vim.fn.fnameescape(note_path))
        end
        return true
      end

      -- Find active tasks under each `# Tasks` heading; rg itself is line-oriented.
      local function scan_tasks()
        local output = vim.fn.systemlist({
          "rg",
          "--no-heading",
          "--line-number",
          "--sort",
          "path",
          "--glob",
          "*.md",
          "-e",
          "^#+ ",
          "-e",
          "^\\s*[-+*] \\[[ -]\\]",
          vim.fn.expand(vim.env.ZK_NOTEBOOK_DIR or "~/Cloud/Sync/notebook"),
        })

        -- rg exits 1 when nothing matched; anything above that is a real error.
        if vim.v.shell_error > 1 then
          vim.notify("zk: task scan failed", vim.log.levels.ERROR)
          return {}
        end

        local tasks, current_file, in_tasks = {}, nil, false
        for _, entry in ipairs(output) do
          local file, lnum, text = entry:match("^(.-):(%d+):(.*)$")
          if file then
            if file ~= current_file then
              current_file, in_tasks = file, false
            end
            if text:match("^#+ ") then
              in_tasks = text:match("^#+%s+Tasks%s*$") ~= nil
            elseif in_tasks then
              table.insert(tasks, { file = file, lnum = tonumber(lnum), text = vim.trim(text) })
            end
          end
        end
        return tasks
      end

      local function zk_tasks()
        local conf = require("telescope.config").values
        require("telescope.pickers")
          .new({}, {
            prompt_title = "zk active tasks",
            finder = require("telescope.finders").new_table({
              results = scan_tasks(),
              entry_maker = function(task)
                local note = vim.fn.fnamemodify(task.file, ":t:r")
                local display = string.format("%s  %s", note, task.text)
                return { display = display, ordinal = display, filename = task.file, lnum = task.lnum }
              end,
            }),
            previewer = conf.grep_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      -- Append a new task under the `# Tasks` heading of today's daily note.
      local function zk_task_new()
        if not open_daily_note() then
          return
        end

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local heading
        for i, line in ipairs(lines) do
          if line:match("^# Tasks%s*$") then
            heading = i
            break
          end
        end

        if not heading then
          vim.notify("zk: no `# Tasks` heading in today's note", vim.log.levels.WARN)
          return
        end

        -- Append after the last non-blank line of the Tasks section.
        local insert_at = lines[heading + 1] == "" and heading + 1 or heading
        for i = heading + 1, #lines do
          if lines[i]:match("^#") then
            break
          end
          if lines[i] ~= "" then
            insert_at = i
          end
        end

        vim.api.nvim_buf_set_lines(0, insert_at, insert_at, false, { "- [ ] " })
        vim.api.nvim_win_set_cursor(0, { insert_at + 1, 0 })
        vim.cmd.startinsert({ bang = true })
      end

      vim.api.nvim_create_user_command("ZkTasks", zk_tasks, { desc = "zk: list active tasks" })
      vim.api.nvim_create_user_command("ZkTaskNew", zk_task_new, { desc = "zk: add a task to today's daily note" })

      map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts("Create new note"))
      vim.keymap.set("n", "<leader>zd", open_daily_note, opts("Daily note (today)"))
      map("n", "<leader>zr", "<Cmd>ZkNew { dir = 'journal/daily', date = 'tomorrow' }<CR>", opts("Daily note (tomorrow)"))
      map("n", "<leader>zw", "<Cmd>ZkNew { dir = 'journal/weekly', date = 'today' }<CR>", opts("Weekly note"))
      map("n", "<leader>zo", "<Cmd>ZkNotes { sort = {'modified'} }<CR>", opts("Open notes"))
      map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts("Open notes by tags"))
      map("v", "<leader>zm", ":'<,'>ZkMatch<CR>", opts("Search notes by selection"))
      map("n", "<leader>zs", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts("Search notes"))
      map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts("Open notes linking to the current buffer"))
      map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts("Open notes linked by the current buffer"))
      vim.keymap.set("n", "<leader>ta", zk_tasks, { silent = true, desc = "Tasks: Active" })
      vim.keymap.set("n", "<leader>tn", zk_task_new, { silent = true, desc = "Tasks: New" })
    end,
  },
}
