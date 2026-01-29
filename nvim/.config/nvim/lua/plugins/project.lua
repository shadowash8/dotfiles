return {
    {
        "ahmedkhalf/project.nvim",
        config = function()
            local status_ok, project = pcall(require, "project_nvim")
            if not status_ok then
                return
            end
            project.setup({
                active = true,
                on_config_done = nil,
                manual_mode = false,
                detection_methods = { "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                silent_chdir = true,
                ignore_lsp = {},

            })
        end,
    },
}
