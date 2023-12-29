local U = {}

local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function U.fmt_on_save(client, buf)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
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

function U.go_to_definition_split()
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

return U
