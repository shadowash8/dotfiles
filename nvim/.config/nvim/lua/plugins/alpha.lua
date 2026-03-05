return {
    {
        'goolord/alpha-nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local status_ok, alpha = pcall(require, "alpha")
            if not status_ok then
                return
            end

            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[     /\/\/\                            /  \  ]],
                [[    | \  / |                         /      \    ]],
                [[    |  \/  |                       /          \    ]],
                [[    |  /\  |----------------------|     /\     |    ]],
                [[    | /  \ |                      |    /  \    |    ]],
                [[    |/    \|                      |   /    \   |    ]],
                [[    |\    /|                      |  | (  ) |  |    ]],
                [[    | \  / |                      |  | (  ) |  |    ]],
                [[    |  \/  |                 /\   |  |      |  |   /\    ]],
                [[    |  /\  |                /  \  |  |      |  |  /  \    ]],
                [[    | /  \ |               |----| |  |      |  | |----|    ]],
                [[    |/    \|---------------|    | | /|   .  |\ | |    |    ]],
                [[    |\    /|               |    | /  |   .  |  \ |    |    ]],
                [[    | \  / |               |    /    |   .  |    \    |    ]],
                [[    |  \/  |               |  /      |   .  |      \  |    ]],
                [[    |  /\  |---------------|/        |   .  |        \|    ]],
                [[    | /  \ |              /    NASA  |   .  | Artemis  \    ]],
                [[    |/    \|              (          |      |           )    ]],
                [[    |/\/\/\|               |    | |--|      |--| |    |    ]],
                [[    ------------------------/  \-----/  \/  \-----/  \--------    ]],
                [[                            \\//     \\//\\//     \\//    ]],
                [[                             \/       \/  \/       \/    ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", function()
                    require("fzf-lua").files()
                end),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("t", "󰦨  Find text", function()
                    require("fzf-lua").live_grep()
                end),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }

            local function footer()
                return "Welcome back Ashwin"
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
            alpha.setup(dashboard.opts)
        end,
    },
}
