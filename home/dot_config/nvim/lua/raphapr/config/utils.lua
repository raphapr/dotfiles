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

function U.run_async(command, description)
  if vim.fn.executable(command[1]) ~= 1 then
    vim.notify(command[1] .. " is not executable", vim.log.levels.ERROR, { title = description })
    return
  end

  vim.system(command, { text = true }, function(result)
    if result.code == 0 then
      return
    end

    vim.schedule(function()
      local message = vim.trim(result.stderr or "")
      if message == "" then
        message = description .. " failed with exit code " .. result.code
      end
      vim.notify(message, vim.log.levels.ERROR, { title = description })
    end)
  end)
end

return U
