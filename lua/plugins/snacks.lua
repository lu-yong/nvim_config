return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        list = {
          keys = {
            ["<c-j>"] = false,
            ["<c-k>"] = false,
          },
        },
      },
    },
    styles = {
      terminal = {
        keys = {
          term_normal = {
            "<esc>",
            function(self)
              self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
              if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd("stopinsert")
              else
                -- change the timer to 300ms, default is 200ms
                self.esc_timer:start(300, 0, function() end)
                return "<esc>"
              end
            end,
            mode = "t",
            expr = true,
            desc = "Double escape to normal mode",
          },
        },
      },
    },
  },
}
