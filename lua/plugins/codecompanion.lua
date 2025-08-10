local PROMPTS = require("plugins.codecomanion-extension.prompts")

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>A", group = "ai(CodeCompanion)", icon = " " },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",

    init = function()
      require("plugins.codecomanion-extension.companion-notification").init()
    end,

    event = "VeryLazy",
    lazy = true,
    version = "*",
    dependencies = {
      "ravitemer/codecompanion-history.nvim", -- for history
    },
    keys = {
      { "<leader>Aa", "<cmd>CodeCompanionChat Add<cr>", desc = "codecompanion: add", mode = { "n", "v" } },
      { "<leader>Ai", "<cmd>CodeCompanion<cr>", desc = "codecompanion: inline", mode = { "n", "v" } },
      { "<leader>Ah", "<cmd>CodeCompanionHistory<cr>", desc = "codecompanion: history", mode = { "n", "v" } },
      { "<leader>At", "<cmd>CodeCompanionChat Toggle<cr>", desc = "codecompanion: chat", mode = { "n", "v" } },
      { "<leader>Ap", "<cmd>CodeCompanionActions<cr>", desc = "codecompanion: prompt action", mode = { "n", "v" } },
      { "<leader>Ae", "<cmd>CodeCompanion /explain<cr>", desc = "codeompanion: explain code", mode = "v" },
      { "<leader>Af", "<cmd>CodeCompanion /fix<cr>", desc = "codeompanion: fix code", mode = "v" },
      { "<leader>Al", "<cmd>CodeCompanion /lsp<cr>", desc = "codeompanion: explain lsp diagnostic", mode = "v" },
      { "<leader>Ad", "<cmd>CodeCompanion /inline-doc<cr>", desc = "codeompanion: inline document code", mode = "v" },
      { "<leader>AD", "<cmd>CodeCompanion /doc<cr>", desc = "codeompanion: document code", mode = "v" },
      { "<leader>Ar", "<cmd>CodeCompanion /refactor<cr>", desc = "codeompanion: refactor code", mode = "v" },
      { "<leader>AR", "<cmd>CodeCompanion /review<cr>", desc = "codeompanion: review code", mode = "v" },
      { "<leader>An", "<cmd>CodeCompanion /naming<cr>", desc = "codeompanion: better naming", mode = "v" },
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.5-sonnet",
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
                default = "qwen3-coder-plus", -- define llm model to be used
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
            make_tools = true,
            show_server_tools_in_chat = true,
            add_mcp_prefix_to_tool_names = false,
            format_tool = nil,
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        history = {
          enabled = true,
          opts = {
            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            picker = "snacks",
            ---Directory path to save the chats
            expiration_days = 14,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          },
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = function(adapter)
              local model_name = ""
              if adapter.schema and adapter.schema.model and adapter.schema.model.default then
                local model = adapter.schema.model.default
                if type(model) == "function" then
                  model = model(adapter)
                end
                model_name = "(" .. model .. ")"
              end
              return "  " .. adapter.formatted_name .. model_name
            end,
            user = " User",
          },
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
            codeblock = {
              modes = {
                n = "<C-b>",
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
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
          adapter = "copilot",
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
      prompt_library = PROMPTS.PROMPT_LIBRARY,
    },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
  },
  {
    "ravitemer/mcphub.nvim", -- for mcphub server
    lazy = true,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
  },
  {
    "folke/noice.nvim", -- for progress notifications
    lazy = true,
  },
  {
    "echasnovski/mini.diff",
    lazy = true,
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
