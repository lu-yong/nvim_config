return {
  -- for avante use blink.cmp
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
    config = function()
      -- monkeypatch cmp.ConfirmBehavior for Avante
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        compat = { "avante_commands", "avante_mentions", "avante_files" },
        -- LSP score_offset is typically 60
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_menu_visible() then
              return
            else
              return cmp.snippet_backward()
            end
          end,
          "select_prev",
          "fallback",
        },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_menu_visible() then
              return
            else
              return cmp.snippet_forward()
            end
          end,
          "select_next",
          "fallback",
        },
        ["<Esc>"] = { "hide", "fallback" },
      },
    },
  },
}
