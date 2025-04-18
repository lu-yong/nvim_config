return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
  },
  opts = {
    sources = {
      -- Add 'avante' to the list
      default = { "avante" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
          },
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
      ['<Esc>'] = { 'hide', 'fallback' },
    },
  },
}
