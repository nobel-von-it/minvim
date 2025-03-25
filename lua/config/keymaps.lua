-- This keymaps are non-reliance with lazy.nvim and plugins
vim.keymap.set('n', '<leader>e', vim.cmd.Explore, { desc = 'Open vim Explorer' })
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Remap escape to jk', silent = true, noremap = true })
vim.keymap.set('n', '<leader>n', vim.cmd.nohl,
    { desc = 'Shortcut for nohl (uncolor searched)', silent = true, noremap = true })

-- Indent but they may be removed in future because '>' and '<' are existing keymaps and works same way
vim.keymap.set('v', '<Tab>', ':<C-u>exec "\'<,\'>normal! I\\t"<CR>',
    { desc = 'Indent selected lines', silent = true, noremap = true })
vim.keymap.set('v', '<S-Tab>', ':<C-u>exec "\'<,\'>normal! x"<CR>',
    { desc = 'Dedent selected lines', silent = true, noremap = true })
