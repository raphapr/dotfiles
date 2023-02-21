-- go.nvim
require("go").setup()

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

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.configure("tsserver", {
	on_attach = function(client, bufnr)
		print("hello tsserver")
	end,
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false, silent = true }
	local map = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	map("n", "<C-k>", "<C-w>k", noremap)

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references()
	end, opts)
	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>ws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

-- null-ls

local nls = require("null-ls")
local U = require("raphapr.plugins.utils")

local fmt = nls.builtins.formatting

-- Configuring null-ls
nls.setup({
	sources = {
		fmt.black.with({ extra_args = { "--fast" } }),
		fmt.stylua,
		fmt.shfmt,
		fmt.gofumpt,
		fmt.prettier.with({
			filetypes = { "html", "css", "yaml", "markdown", "json" },
		}),
	},
	on_attach = function(client, bufnr)
		U.fmt_on_save(client, bufnr)
	end,
})
