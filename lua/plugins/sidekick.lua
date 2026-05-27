return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "ai(Sidekick)", icon = " ", mode = { "n", "v" } },
      },
    },
  },
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        win = {
          keys = {
            buffers       = { "<A-b>", "buffers"   , mode = "nt", desc = "open buffer picker" },
            files         = { "<A-f>", "files"     , mode = "nt", desc = "open file picker" },
          },
        },
      },
    },
    keys = {
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n", "v" }, expr = true },
    },
  },
}
