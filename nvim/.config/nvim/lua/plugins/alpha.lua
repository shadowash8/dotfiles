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
                [[ ⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⡄⠀⠀ ]],
                [[ ⢰⠒⠒⢻⣿⣶⡒⠒⠒⠒⠒⠒⠒⠒⠒⠒⡶⠊⣰⣓⡒⡆ ]],
                [[ ⢸⢸⢻⣭⡙⢿⣿⣍⡉⠉⡇⣯⠉⠉⣩⠋⢀⣔⠕⢫⡇⡇ ]],
                [[ ⢸⢸⣈⡻⣿⣶⣽⡸⣿⣦⡇⣧⠠⠊⣸⢶⠋⢁⡤⠧⡧⡇ ]],
                [[ ⢸⢸⠻⣿⣶⣝⠛⣿⣮⢻⠟⣏⣠⠞⠁⣼⡶⠋⢀⣴⡇⡇ ]],
                [[ ⢸⢸⣿⣶⣍⠻⠼⣮⡕⢁⡤⢿⢁⡴⠊⣸⣵⠞⠋⢠⡇⡇ ]],
                [[ ⢸⢘⣛⡻⣿⣧⢳⣿⣧⠎⢀⣾⠋⡠⠞⢱⢇⣠⡴⠟⡇⡇ ]],
                [[ ⢸⢸⠹⣿⣷⣎⣉⣻⢁⡔⢁⢿⡏⢀⣤⢾⡟⠁⣀⣎⡇⡇ ]],
                [[ ⢸⢸⠲⣶⣭⡛⠚⢿⢋⡔⢁⣼⠟⢋⣠⣼⠖⠋⢁⠎⡇⡇ ]],
                [[ ⢸⢸⢤⣬⣛⠿⠞⣿⢋⠔⣉⣾⠖⠋⢁⣯⡴⠞⢃⠂⡇⡇ ]],
                [[ ⢸⢸⠀⢙⣻⢿⣧⣾⡵⠚⣉⣯⠶⠛⣹⣧⠤⢮⠁⠀⡇⡇ ]],
                [[ ⠸⣘⠢⣄⠙⠿⢷⡡⠖⣋⣽⠥⠒⣩⣟⣤⣔⣁⡤⠖⣃⠇ ]],
                [[ ⠀⠀⠙⠢⢍⣻⡿⠒⢉⣴⣗⣚⣽⣋⣀⣤⣊⠥⠒⠉⠀⠀ ]],
                [[ ⠀⠀⠀⢀⣔⠥⠒⢮⣙⠾⠀⠷⣚⡭⠞⠉⠛⠦⣀⠀⠀⠀ ]],
                [[ ⠀⠀⠀⠉⠀⠀⠀⠀⠈⠑⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", function()
                    Snacks.picker.smart()
                end),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "  Find project", function()
                    Snacks.picker.projects()
                end),
                dashboard.button("r", "󰑓  Recently used files", function()
                    Snacks.picker.recent()
                end),
                dashboard.button("t", "󰦨  Find text", function()
                    Snacks.picker.grep()
                end),
                dashboard.button("c", "  Configuration", function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
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
