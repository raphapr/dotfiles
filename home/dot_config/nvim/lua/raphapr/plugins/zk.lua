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
            vim.diagnostic.config({ signs = false, underline = false })
          end,
        },
      })
      local map = vim.api.nvim_set_keymap
      local function opts(desc)
        return { noremap = true, silent = true, desc = "zk: " .. desc }
      end
      map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts("Create new note"))
      map("n", "<leader>zd", "<Cmd>ZkNew { dir = 'journal/daily', date = 'today' }<CR>", opts("Daily note (today)"))
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
