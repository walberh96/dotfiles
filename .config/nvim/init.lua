-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "catppuccin/nvim",  -- Plugin name
      name = "catppuccin", -- You can still specify a name
      priority = 1000, -- Plugin priority
      config = function()
        -- Set the colorscheme to catppuccin-mocha after the plugin is loaded
        vim.cmd("colorscheme catppuccin-mocha")
      end
    }

    -- Add other plugins here
  },
  -- Automatically check for plugin updates
  checker = { enabled = true },
})

-- You can explicitly set the colorscheme here to ensure it’s applied
-- even if lazy.nvim isn't fully set up yet (this shouldn't be necessary,
-- but it's here as a fallback).
vim.cmd("colorscheme catppuccin-mocha")

