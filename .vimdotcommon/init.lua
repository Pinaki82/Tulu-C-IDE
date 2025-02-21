-- init.lua

-- =============================================================================
-- Neovim Configuration for Windsurf Editor
-- =============================================================================
-- This configuration is designed to work with the Neovim plugin for the Windsurf
-- editor, a fork of VSCode. It aims to provide a seamless integration experience
-- for users familiar with Vim and Neovim.
--
-- Windsurf Version: 1.3.4
-- Codeium Version: 1.36.1
-- Codeium Commit: ff5014a12e72ceb812f9e7f61876befac66725e5
-- VSCode OSS Version: 1.94.0
-- Commit: ff5014a12e72ceb812f9e7f61876befac66725e5
-- Date: 2025-02-14T20:42:19.835Z
-- Electron: 30.5.1
-- ElectronBuildId: undefined
-- Chromium: 124.0.6367.243
-- Node.js: 20.16.0
-- V8: 12.4.254.20-electron.0
-- OS: Linux x64 6.1.0-31-amd64
--
-- Plugin Information:
-- Name: VSCode Neovim
-- Id: asvetliakov.vscode-neovim
-- Description: Vim mode for VSCode, powered by Neovim
-- Version: 1.18.17
-- Publisher: asvetliakov
-- VS Marketplace Link: https://open-vsx.org/vscode/item?itemName=asvetliakov.vscode-neovim
--
-- Configuration Details:
-- This configuration is written by Kimi (Kimi AI Assistant, https://kimi.moonshot.cn)
--- as a reference for
-- users who are integrating Neovim with the Windsurf editor. It is intended to
-- provide a basic setup that can be customized further based on individual needs.
--
-- Note:
-- This configuration should be loaded from a custom directory by the Neovim
-- plugin of the Windsurf editor. It is not intended to replace the users'
-- existing GVim/Vim/Neovim configuration. Some features may not work properly.
-- =============================================================================

-- Set leader key to \
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Disable Vi compatibility mode
vim.opt.compatible = false

-- Enable filetype detection and plugins
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])

-- Line numbers (hybrid mode)
vim.opt.number = true               -- Show absolute line numbers
vim.opt.relativenumber = true       -- Show relative line numbers

-- Automatic number toggle
vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    {
        group = "numbertoggle",
        callback = function()
            if vim.wo.number and vim.fn.mode() ~= "i" then
                vim.wo.relativenumber = true
            end
        end,
    }
)
vim.api.nvim_create_autocmd(
    { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    {
        group = "numbertoggle",
        callback = function()
            if vim.wo.number then
                vim.wo.relativenumber = false
            end
        end,
    }
)

-- UI configuration
vim.opt.laststatus = 3              -- Always show status line
vim.opt.colorcolumn = "80"          -- Safe margin at column 80
vim.opt.scrolloff = 8               -- Scroll offset
vim.opt.cursorline = true           -- Highlight current line
vim.opt.cursorcolumn = true         -- Highlight current column

-- Editing settings
vim.opt.tabstop = 2                 -- Tab width
vim.opt.shiftwidth = 2              -- Indentation width
vim.opt.softtabstop = 2             -- Soft tab width
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smarttab = true             -- Smart tab behavior
vim.opt.autoindent = true           -- Auto indentation
vim.opt.smartindent = true          -- Smart indentation
vim.opt.cindent = true              -- C-style indentation
vim.opt.preserveindent = true       -- Preserve indentation structure
vim.opt.shiftround = true           -- Round indent to shiftwidth
vim.opt.undolevels = 1000           -- Undo levels
vim.opt.history = 1000              -- Command & search history length

-- Search settings
vim.opt.ignorecase = true           -- Ignore case in search
vim.opt.smartcase = true            -- Case-sensitive if uppercase is present
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.incsearch = true            -- Incremental search

-- Window management
vim.opt.hidden = false              -- Remove buffer when closing
vim.opt.mouse = "a"                 -- Enable mouse support
vim.opt.wrap = false                -- Disable line wrapping

-- Completion & wildmenu
vim.opt.complete = ".,w,b,u,U,k,t,i,d" -- Tab completion options
vim.opt.wildmenu = true             -- Enable wildmenu
vim.opt.wildmode = "longest:full"   -- Wildmenu behavior

-- Folding
--- Conflicts with Windsurf keybindings. Windsurf manages key combinations.
-- -- -- vim.opt.foldmethod = "syntax"       -- Use syntax-based folding
-- -- -- vim.opt.foldcolumn = "5"            -- Fold column width

-- Key mappings
-- Swap ; and : for command mode
-- https://vi.stackexchange.com/questions/44653/swap-k-and-t-not-working
vim.keymap.set('n', ';', ':', { remap = false, desc = 'Help' })
vim.keymap.set('n', ';', ':', { remap = false, desc = 'Till (backwards)' })

-- jk/kj to escape insert mode
vim.cmd([[imap jk <ESC>]])
vim.cmd([[imap kj <ESC>]])

-- Windows management
vim.keymap.set("n", "<C-F4>", "<cmd>lua CloseFile()<CR>", { noremap = true, desc = "Close current buffer" })
vim.keymap.set("n", "<C-D>", ":bdelete<CR>", { noremap = true, desc = "Delete current buffer" })

-- Clipboard mappings (uses system clipboard)
--- Conflicts with Windsurf keybindings. Windsurf manages key combinations.
-- -- -- vim.keymap.set("v", "<C-C>", '"+y', { noremap = true, desc = "Copy" })
-- -- -- vim.keymap.set("v", "<C-X>", '"+x', { noremap = true, desc = "Cut" })
-- -- -- vim.keymap.set("n", "<C-V>", '"+p', { noremap = true, desc = "Paste in normal mode" })
-- -- -- vim.keymap.set("v", "<C-V>", '"+p', { noremap = true, desc = "Paste in visual mode" })
-- -- -- vim.keymap.set("i", "<C-V>", '<C-R>+', { noremap = true, desc = "Paste in insert mode" })

-- Save file
--- Conflicts with Windsurf keybindings. Windsurf manages key combinations.
-- -- -- vim.keymap.set("n", "<C-S>", '<Esc>:w<CR>', { noremap = true, desc = "Save file" })
vim.keymap.set("i", "<C-S>", '<C-O>:w<CR>', { noremap = true, desc = "Save file in insert mode" })

-- Undo and redo mappings
--- Conflicts with Windsurf keybindings. Windsurf manages key combinations.
-- -- -- vim.keymap.set("n", "<C-Z>", "u", { noremap = true, desc = "Undo" })
-- -- -- vim.keymap.set("i", "<C-Z>", "<C-O>u", { noremap = true, desc = "Undo in insert mode" })
-- -- -- vim.keymap.set("n", "<C-Y>", "u", { noremap = true, desc = "Redo" })

-- Code folding
--- Conflicts with Windsurf keybindings. Windsurf manages key combinations.
-- -- -- vim.keymap.set("n", "<F8>", "za", { noremap = true, desc = "Toggle fold" })
-- -- -- vim.keymap.set("n", "<S-F8>", "zR", { noremap = true, desc = "Open all folds" })
-- -- -- vim.keymap.set("n", "<Space>", "za", { noremap = true, desc = "Toggle fold under cursor" })

-- Custom functions
function CloseFile()
  if vim.opt.previewwindow:get() then
    vim.cmd("close")
  elseif vim.fn.winnr("$") > 1 then
    vim.cmd("bdelete")
  else
    print("Cannot delete last buffer")
  end
end

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 1 and last_pos <= vim.fn.line("$") then
      vim.cmd("normal " .. last_pos .. "G")
    end
  end,
})

-- GUI window position
vim.api.nvim_create_autocmd("GUIEnter", {
  callback = function()
    vim.cmd("winpos 0 0")
  end,
})

-- Strip trailing whitespace on save
--- Does not work.
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/^\t* //e]])
  end,
})
