local function filename()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return fname
  end
  return fname .. ""
end

local function filetype()
  return string.format(" [%s] ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return "%l,%c"
end

Statusline = {}
Statusline.active = function()
  return table.concat({
    "%#StatusLine# ",
    filename(),
    "%=%S",
    lineinfo(),
    filetype(),
  })
end

Statusline.inactive = function()
  return "%F"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
]], false)
