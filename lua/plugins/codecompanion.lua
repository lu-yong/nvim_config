return {
  "olimorris/codecompanion.nvim",
  --config = true,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "codecompanion: add", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "codecompanion: chat", mode = { "n", "v" } },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "codecompanion: inline", mode = { "n", "v" } },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        qwen = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "qwen",
            formatted_name = "Qwen",
            env = {
              url = "https://dashscope.aliyuncs.com/compatible-mode", -- optional: default value is ollama url http://127.0.0.1:11434
              api_key = "DASHSCOPE_API_KEY", -- optional: if your endpoint is authenticated
              --chat_url = "/v1/chat/completions", -- optional: default value, override if different
            },
            schema = {
              model = {
                default = "qwen-coder-plus-latest", -- define llm model to be used
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "qwen",
        },
        inline = {
          adapter = "qwen",
        },
        agent = {
          adapter = "qwen",
        },
      },
    })
  end,
}
