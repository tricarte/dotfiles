return {
  "nvim-flutter/flutter-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "stevearc/dressing.nvim", -- Optional: UI enhancements
  },
  config = function()
    require("flutter-tools").setup({
      widget_guides = { enabled = true },
      closing_tags = {
        highlight = "Comment", -- highlight for closing tag
        prefix = "// ", -- character to use for close tag e.g. > //
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit", -- or "vsplit"
      },
      outline = {
        auto_open = false, -- default is false
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          -- background = false, -- highlight the background
          -- background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          -- foreground = false, -- highlight the foreground
          -- virtual_text = true, -- show the highlight using virtual text
          -- virtual_text_str = "■", -- the virtual text character to highlight
        },
      },
    })
  end,
}
