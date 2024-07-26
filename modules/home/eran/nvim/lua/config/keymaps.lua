-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<C-l>")
vim.keymap.set("n", "<C-l>", vim.cmd.TmuxNavigateRight, { desc = "Window Right" })
vim.keymap.del("n", "<C-k>")
vim.keymap.set("n", "<C-k>", vim.cmd.TmuxNavigateUp, { desc = "Window Up" })
vim.keymap.del("n", "<C-j>")
vim.keymap.set("n", "<C-j>", vim.cmd.TmuxNavigateDown, { desc = "Window Down" })
vim.keymap.del("n", "<C-h>")
vim.keymap.set("n", "<C-h>", vim.cmd.TmuxNavigateLeft, { desc = "Window Left" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Clipbord Paste" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Clipbord Paste" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Clipbord Paste" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Clipbord Yank" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Clipbord Yank" })
vim.keymap.set("v", "<leader>d", '"+d', { desc = "Clipbord Yank" })
vim.keymap.set("n", "<leader>d", '"+d', { desc = "Clipbord Yank" })
