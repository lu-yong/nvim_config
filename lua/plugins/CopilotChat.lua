return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = {
    { "<leader>aa", false },
    {
      "<leader>ac",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
  },
}
