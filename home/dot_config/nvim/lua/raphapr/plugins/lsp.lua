-- # Go to definition (in a split)
local function go_to_definition_split()
  vim.lsp.buf.definition({
    on_list = function(options)
      -- if there are multiple items, warn the user
      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      -- Open the first item in a vertical split
      local item = options.items[1]
      local cmd = "vsplit +" .. item.lnum .. " " .. item.filename .. "|" .. "normal " .. item.col .. "|"

      vim.cmd(cmd)
    end,
  })
end

-- go.nvim
-- DAP UI keymaps
-- c	continue
-- n	next
-- s	step
-- o	stepout
-- S	cap S: stop debug
-- u	up
-- D	cap D: down
-- C	cap C: run to cursor
-- b	toggle breakpoint
-- P	cap P: pause
-- p	print, hover value (also in visual mode)

require("go").setup()

vim.api.nvim_create_user_command("GoModTidy", function()
  vim.cmd.write()
  vim.cmd("!go mod tidy -v")
  vim.cmd.LspRestart()
  vim.notify("go mod tidy finished")
end, {})

vim.keymap.set("n", "<leader>db", ":GoDebug<CR>", { noremap = true, desc = "Start delve for debugging" })
vim.keymap.set("n", "<leader>fs", ":GoFillStruct<CR>", { noremap = true, desc = "Fill struct in Go" })
vim.keymap.set("n", "<leader>gm", ":GoModTidy<CR>", { noremap = true, desc = "Run go mod tidy and restart lsp" })

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  hint_prefix = "󰏚  ",
})

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Reserve space for diagnostic icons
vim.opt.signcolumn = "yes"

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.set_preferences({ suggest_lsp_servers = false })

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  "tsserver",
  "eslint",
  "lua_ls",
  "gopls",
  "terraformls",
  "jsonls",
  "tflint",
  "pyright",
  "bashls",
  "yamlls",
})

lsp.configure("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

lsp.configure("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.on_attach(function(_, bufnr)
  local function opts(desc)
    return { desc = "lsp: " .. desc, buffer = bufnr, remap = false, silent = true }
  end

  vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts("lsp: info"))

  vim.keymap.set(
    "n",
    "<leader>ls",
    ":LspStop<CR>:lua vim.notify('lsp stopped')<CR>",
    { silent = true, desc = "lsp: stop" }
  )

  vim.keymap.set(
    "n",
    "<leader>lr",
    ":LspRestart<CR>:lua vim.notify('lsp restart')<CR>",
    { silent = true, desc = "lsp: restart" }
  )

  vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts("go to definition"))
  vim.keymap.set("n", "gs", go_to_definition_split, opts("go to definition (split)"))
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, opts("references"))
  vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
  end, opts("open float window"))
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts("hover function"))
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts("code action"))
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts("rename"))
  vim.keymap.set("n", "[[", function()
    vim.diagnostic.goto_next()
  end, opts("go to next issue"))
  vim.keymap.set("n", "]]", function()
    vim.diagnostic.goto_prev()
  end, opts("go to previous issue"))
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
