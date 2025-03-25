-- vim-tmux-navigator Configuration
-- This script sets up the 'vim-tmux-navigator' plugin, which allows seamless navigation between
-- Neovim and tmux panes using customizable keybindings. It helps you to easily move between Neovim
-- windows and tmux panes without having to switch between the two manually.
-- You should also configure .tmux.conf (install the plugin) to enable tmux integration.

return {
    'christoomey/vim-tmux-navigator', -- Plugin repository for vim-tmux-navigator.

    -- Commands for navigating tmux panes from Neovim.
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
        'TmuxNavigatorProcessList',
    },

    -- Keybindings for navigating between tmux panes from Neovim.
    keys = {
        { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
        { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
        { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
        { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
}

