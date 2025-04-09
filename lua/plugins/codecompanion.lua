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
    -- { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "codecompanion: add", mode = { "n", "v" } },
    -- { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "codecompanion: chat", mode = { "n", "v" } },
    -- { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "codecompanion: inline", mode = { "n", "v" } },
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
            },
            schema = {
              model = {
                default = "qwen-max-latest", -- define llm model to be used
              },
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "openrouter",
            formatted_name = "Claude-3.7-Sonnet",
            env = {
              url = "https://openrouter.ai/api/v1", -- optional: default value is ollama url http://127.0.0.1:11434
              api_key = "OPENROUTER_API_KEY", -- optional: if your endpoint is authenticated
            },
            schema = {
              model = {
                default = "anthropic/claude-3.7-sonnet", -- define llm model to be used
              },
            },
          })
        end,
        silicon_flow = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "silicon_flow",
            formatted_name = "DeepSeek",
            env = {
              url = "https://api.siliconflow.cn/", -- optional: default value is ollama url http://127.0.0.1:11434
              api_key = "DEEPSEEK_API_KEY", -- optional: if your endpoint is authenticated
            },
            schema = {
              model = {
                default = "deepseek-ai/DeepSeek-V3", -- define llm model to be used
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
