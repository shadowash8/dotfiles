return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                -- custom mappings
                local function change_root_to_node(node)
                    if node == nil then
                        node = api.tree.get_node_under_cursor()
                    end

                    if node ~= nil and node.type == "directory" then
                        vim.api.nvim_set_current_dir(node.absolute_path)
                    end
                    api.tree.change_root_to_node(node)
                end

                local function change_root_to_parent(node)
                    local abs_path
                    if node == nil then
                        abs_path = api.tree.get_nodes().absolute_path
                    else
                        abs_path = node.absolute_path
                    end

                    local parent_path = vim.fs.dirname(abs_path)
                    vim.api.nvim_set_current_dir(parent_path)
                    api.tree.change_root(parent_path)
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
                vim.keymap.set('n', '<C-]>', change_root_to_node, opts('CD'))
                vim.keymap.set('n', '<2-RightMouse>', change_root_to_node, opts('CD'))
                vim.keymap.set('n', '-', change_root_to_parent, opts('Up'))
            end

            -- pass to setup along with your other options
            require("nvim-tree").setup {
                ---
                on_attach = my_on_attach,
                ---
            }
        end,

        keys = {
            {
                "<leader>e",
                "<cmd>NvimTreeToggle<CR>",
                desc = "Open mini.files (cwd)",
            },

        }
    },
}
