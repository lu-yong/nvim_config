return {
  "olimorris/codecompanion.nvim",

  init = function()
    require("plugins.codecomanion-extension.companion-notification").init()
  end,

  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim", -- for mcphub server
    "folke/noice.nvim", -- for progress notifications
    "ravitemer/codecompanion-history.nvim", -- for history
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      ft = function(_, ft)
        vim.list_extend(ft, { "codecompanion" })
      end,
      opts = function(_, opts)
        opts.file_types = vim.list_extend(opts.file_types or {}, { "codecompanion" })
      end,
    },
  },
  keys = {
    { "<leader>A", "", desc = "+ai(CodeCompanion)", mode = { "n", "v" } },
    { "<leader>Aa", "<cmd>CodeCompanionChat Add<cr>", desc = "codecompanion: add", mode = { "n", "v" } },
    { "<leader>Ac", "<cmd>CodeCompanionChat Add<cr>", desc = "codecompanion: add", mode = "v" },
    { "<leader>Ai", "<cmd>CodeCompanion<cr>", desc = "codecompanion: inline", mode = { "n", "v" } },
    { "<leader>Ah", "<cmd>CodeCompanionHistory<cr>", desc = "codecompanion: history", mode = { "n", "v" } },
    { "<leader>At", "<cmd>CodeCompanionChat Toggle<cr>", desc = "codecompanion: chat", mode = { "n", "v" } },
    { "<leader>Ap", "<cmd>CodeCompanionActions<cr>", desc = "codecompanion: prompt action", mode = { "n", "v" } },
  },
  opts = {
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.5-flash-preview-05-20",
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
              default = "qwen-plus-latest", -- define llm model to be used
            },
          },
        })
      end,
      openrouter = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "openrouter",
          formatted_name = "Openrouter",
          env = {
            url = "https://openrouter.ai/api/", -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = "OPENROUTER_API_KEY", -- optional: if your endpoint is authenticated
          },
          schema = {
            model = {
              default = "anthropic/claude-sonnet-4", -- define llm model to be used
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
              default = "deepseek-ai/DeepSeek-R1", -- define llm model to be used
            },
          },
        })
      end,
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      history = {
        enabled = true,
        opts = {
          -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
          picker = "default",
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
    },
    strategies = {
      chat = {
        adapter = "gemini",
        keymaps = {
          close = {
            modes = {
              n = "q",
              i = "<C-q>",
            },
          },
          stop = {
            modes = {
              n = "<C-c>",
              i = "<C-c>",
            },
          },
          regenerate = {
            modes = {
              n = "<C-r>",
            },
          },
          codeblock = {
            modes = {
              n = "<C-b>",
            },
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
        adapter = "gemini",
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
  },
}
