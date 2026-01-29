return {{
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
        require("todo-comments").setup {}
    end
}}
