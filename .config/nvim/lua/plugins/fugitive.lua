-----------------
--- GIT TOOLS
---------------
return {
    {
        'tpope/vim-fugitive',
        dependencies = {
            'tpope/vim-rhubarb',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, desc = "Git status" })
            vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { noremap = true, desc = "Git commit" })
            vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { noremap = true, desc = "Git push" })
            vim.keymap.set('n', '<leader>gl', ':Git pull<CR>', { noremap = true, desc = "Git pull" })
            vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { noremap = true, desc = "Git blame" })
            vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { noremap = true, desc = "Git diff split" })
            vim.keymap.set('n', '<leader>gr', ':Gread<CR>', { noremap = true, desc = "Git read (checkout)" })
            vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { noremap = true, desc = "Git write (stage)" })
            require('gitsigns').setup {
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = 'rounded',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                on_attach = function()
                    local gs = package.loaded.gitsigns
                    vim.keymap.set('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc = "Next git hunk"})

                    vim.keymap.set('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc = "Previous git hunk"})

                    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
                    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
                    vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage selected hunks" })
                    vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset selected hunks" })
                    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
                    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
                    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
                    vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
                    vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle line blame" })
                    vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
                    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })
                    vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })
                    vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
                end
            }
        end,
    },
}