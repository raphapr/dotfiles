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
          return
        end

        local note_path = vim.fn.fnamemodify(output[1], ":p")
        local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
        if note_path == current_path then
          return
        end

        vim.cmd.edit(vim.fn.fnameescape(note_path))
      end

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
    end,
  },
}
