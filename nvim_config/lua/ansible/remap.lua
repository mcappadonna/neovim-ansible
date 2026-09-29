-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keep cursor in the middle while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move selection with J and K (Visual mode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- Resize (Normal mode)
vim.keymap.set("n", "<leader>+", ":resize +5<CR>")
vim.keymap.set("n", "<leader>-", ":resize -5<CR>")

-- Move between tabs
vim.keymap.set("n", "<leader>a", ":tabprevious<CR>")
vim.keymap.set("n", "<leader>l", ":tabnext<CR>")

-- Filetype specific remap
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*"},
  callback = function()
    if vim.bo.filetype == "c" then
      -- Show diagnostics (Normal mode)
      vim.keymap.set("n", "<leader>sd", ":lua vim.diagnostic.open_float()<CR>")
      -- Jump to next diagnostic
      vim.keymap.set("n", "<C-n>", ":lua vim.diagnostic.jump({count=1, float=true})<CR>")
    end
    if vim.bo.filetype == "yaml.ansible" then
      -- Show diagnostics (Normal mode)
      vim.keymap.set("n", "<leader>sd", ":lua vim.diagnostic.open_float()<CR>")
      -- Jump to next diagnostic
      vim.keymap.set("n", "<C-n>", ":lua vim.diagnostic.jump({count=1, float=true})<CR>")
      -- Show help of the word under the cursor
      vim.keymap.set("n", "<leader>sh", ":execute 'vnew | setlocal bt=nofile bh=wipe nobl noswapfile | 0read ! ANSIBLE_NOCOLOR=True /usr/bin/ansible-doc' expand('<cword>')<CR>gg")
    end
  end
})
