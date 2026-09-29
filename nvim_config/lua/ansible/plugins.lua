-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Close lazy window after operations
vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyInstall", "LazySync" },
  callback = function()
    vim.cmd("q")
  end,
})

require('lazy').setup({
  spec = { import = "ansible.lazy" },
})

vim.api.nvim_create_autocmd({"BufNew", "BufRead"}, {
  pattern = { "*.yml", "*.yaml" },
  -- command = "set ft=yaml.ansible"
  callback = function(ev)
    if vim.fn.search("hosts:\\|tasks:\\|roles:", "nw") ~= 0 then
      vim.cmd("set ft=yaml.ansible")
    elseif vim.fn.search("apiVersion:\\|kind:", "nw") ~= 0 then
      vim.cmd("set ft=yaml")
    end
  end
})
