local U = {}

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function U.fmt_on_save(client, buf)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = fmt_group,
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({
                    timeout_ms = 3000,
                    buffer = buf,
                })
            end,
        })
    end
end

return U
