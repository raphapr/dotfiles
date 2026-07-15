local U = {}

function U.go_to_definition_split()
  vim.lsp.buf.definition({
    on_list = function(options)
      if #options.items == 0 then
        vim.notify("No definition found", vim.log.levels.INFO)
        return
      end

      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      local item = options.items[1]
      vim.cmd("vsplit " .. vim.fn.fnameescape(item.filename))
      vim.api.nvim_win_set_cursor(0, { item.lnum, math.max(item.col - 1, 0) })
    end,
  })
end

return U
