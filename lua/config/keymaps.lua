-- This keymaps are non-reliance with lazy.nvim and plugins
vim.keymap.set('n', '<leader>e', vim.cmd.Explore, { desc = 'Open vim Explorer' })
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Remap escape to jk', silent = true, noremap = true })
vim.keymap.set('n', '<leader>n', vim.cmd.nohl,
    { desc = 'Shortcut for nohl (uncolor searched)', silent = true, noremap = true })
