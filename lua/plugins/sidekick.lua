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
    keys = {
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n", "v" }, expr = true },
    },
  },
}
