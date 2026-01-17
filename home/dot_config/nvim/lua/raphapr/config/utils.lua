local U = {}

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

function U.get_default_branch()
  local handle = io.popen("git symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null")
  local result = handle and handle:read("*l") or nil
  if handle then
    handle:close()
  end

  if not result then
    return nil
  end

  return result:gsub("^refs/remotes/", "")
end

function U.open_diffview_default_branch()
  local default_branch = U.get_default_branch()
  if not default_branch then
    vim.notify("Could not determine default branch", vim.log.levels.WARN)
    return
  end

  vim.cmd("DiffviewOpen " .. default_branch .. "...HEAD")
end

return U
