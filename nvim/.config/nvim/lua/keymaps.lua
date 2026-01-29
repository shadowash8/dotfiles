local utils = require("utils")

-- Plugins
utils.nmap_leader("a", "<cmd>Alpha<CR>", "Alpha")
utils.nmap_leader("L", "<cmd>Lazy<CR>", "Lazy")

-- Save
utils.nmap_leader("w", "<cmd>w<CR>", "Save")
utils.nmap_leader("qqq", "<cmd>qa<CR>", "Quit All")

-- Clear search highlights
utils.nmap_leader("h", "<cmd>nohlsearch<CR>", "No Highlight")

-- Text manipulation
utils.nmap_leader("u", "<cmd>undo<CR>", "Undo")
utils.nmap_leader("r", "<cmd>redo<CR>", "Redo")

-- Window Management
utils.nmap_leader("=", "<cmd>vertical resize +5<CR>", "Resize +5")
utils.nmap_leader("-", "<cmd>vertical resize -5<CR>", "Resize -5")
utils.nmap_leader("v", "<C-W>v", "Split vertically")
utils.nmap_leader("h", "<C-W>s", "Split horizontally")
utils.nmap_leader("q", "<cmd>q<CR>", "Close Window")
