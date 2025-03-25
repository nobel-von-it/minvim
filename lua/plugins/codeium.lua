-- codeium.vim Configuration
-- This script sets up the Codeium plugin for AI-powered code completions in Neovim.
-- Codeium provides AI-based suggestions for faster coding and requires authentication.
--
-- To enable Codeium, add this plugin to your Neovim configuration and run `:Codeium Auth`.
-- After this step, you can start coding and Codeium will provide intelligent suggestions.
return {
    'Exafunction/codeium.vim', -- Codeium plugin repository.
    event = 'BufEnter',        -- Load the plugin when a buffer is entered for efficiency.

    -- Optional: Configuration function to customize Codeium settings.
    -- For more details, refer to the documentation: https://github.com/Exafunction/codeium.vim
    -- opts = {}
}
-- Fact: The Codeium Neovim version doesn't work in my setup (I don't test it in other devices).
