return {
  "olimorris/codecompanion.nvim",

  init = function()
    require("plugins.codecomanion-extension.companion-notification").init()
  end,

  --config = true,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim", -- for mcphub server
    "folke/noice.nvim", -- for progress notifications
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
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.5-pro-exp-03-25",
              },
            },
          })
        end,
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
            formatted_name = "Openrouter",
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
            formatted_name = "SiliconFlow",
            env = {
              url = "https://api.siliconflow.cn/", -- optional: default value is ollama url http://127.0.0.1:11434
              api_key = "SILICONFLOW_API_KEY", -- optional: if your endpoint is authenticated
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
          adapter = "gemini",
          tools = {
            ["mcp"] = {
              -- calling it in a function would prevent mcphub from being loaded before it's needed
              callback = function()
                return require("mcphub.extensions.codecompanion")
              end,
              description = "Call tools and resources from the MCP Servers",
            },
          },
        },
        inline = {
          adapter = "gemini",
          keymaps = {
            accept_change = {
              modes = {
                n = "<C-a>",
              },
              index = 1,
              callback = "keymaps.accept_change",
              description = "Accept change",
            },
            reject_change = {
              modes = {
                n = "<C-r>",
              },
              index = 2,
              callback = "keymaps.reject_change",
              description = "Reject change",
            },
          },
        },
        agent = {
          adapter = "gemoni",
        },
      },
      display = {
        chat = {
          window = {
            width = 0.35,
          },
        },
        diff = {
          close_chat_at = 10,
        },
      },
      opts = {
        log_level = "ERROR", -- log level for the plugin
      },
    })
  end,
}
