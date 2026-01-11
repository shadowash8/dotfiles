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
                    require('mini.pick').builtin.files({ tool = "git" }, { source = { cwd = vim.fn.getcwd() } })
                end),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "  Find project", function()
                    require('mini.pick').builtin.projects()
                end),
                dashboard.button("r", "󰑓  Recently used files", function()
                    require('mini.extra').pickers.oldfiles()
                end),
                dashboard.button("t", "󰦨  Find text", function()
                    require('mini.pick').builtin.grep_live({ tool = "git" }, { source = { cwd = vim.fn.getcwd() } })
                end),
                dashboard.button("c", "  Configuration", function()
                    require('mini.pick').builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
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
