return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    -- sources = {
    --   default = {
    --   }
    -- }
    -- cmdline is enabled by default, since lazyvim 15.1
    -- cmdline = { enabled = true },
    -- Signature feature comes from somewhere else
    -- signature = {
    --   enabled = true,
    --   window = {
    --     border = "rounded",
    --   },
    -- },
    completion = {
      menu = {
        border = "rounded",
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
      trigger = {
        -- prefetch_on_insert = true,
        show_on_backspace = true,
        -- show_on_backspace_in_keyword = true,
        -- -- When true, will show the completion window after typing a trigger character
        -- show_on_trigger_character = true,
        --
        -- -- When true, will show the completion window after entering insert mode
        -- show_on_insert = true,
        -- -- When both this and show_on_trigger_character are true, will show the completion window
        -- -- when the cursor comes after a trigger character after accepting an item
        -- show_on_accept_on_trigger_character = true,
        --
        -- -- When both this and show_on_trigger_character are true, will show the completion window
        -- -- when the cursor comes after a trigger character when entering insert mode
        -- show_on_insert_on_trigger_character = true,
      },
    },
  },
}
