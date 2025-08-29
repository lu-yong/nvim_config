-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable autoformat
vim.g.autoformat = false
-- disable mini pairs
vim.g.minipairs_disable = true

-- prevent from unexpectedly changing the root
vim.g.root_spec = { "cwd" }
