return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = true,
  version = false, -- -- Never set this value to "*"! Never!
  opts = {
    -- provider = "copilot",
    provider = "gemini",
    auto_suggestions_provider = "siliconflow",
    providers = {
      gemini = {
        model = "gemini-2.5-flash",
      },
      copilot = {
        model = "claude-3.5-sonnet",
      },
      qianwen = {
        __inherited_from = "openai",
        api_key_name = "DASHSCOPE_API_KEY",
        endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
        model = "qwen-plus-latest",
      },
      openrouter = {
        __inherited_from = "openai",
        api_key_name = "OPENROUTER_API_KEY",
        endpoint = "https://openrouter.ai/api/v1",
        model = "anthropic/claude-sonnet-4",
      },
      siliconflow = {
        __inherited_from = "openai",
        api_key_name = "SILICONFLOW_API_KEY",
        endpoint = "https://api.siliconflow.cn/v1",
        model = "deepseek-ai/DeepSeek-R1",
      },
    },
    windows = {
      width = 35,
      ask = {
        start_insert = false,
      },
    },
    mappings = {
      stop = "<leader>as",
      toggle = {
        suggestion = "<leader>aS",
      },
      sidebar = {
        close_from_input = {
          normal = "q",
        },
      },
    },
    -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    disabled_tools = {
      "read_file",
      "create_file",
      "move_path",
      "delete_path",
      "create_dir",
      "bash", -- Built-in terminal access
    },
  },
  keys = {
    { "<leader>a", "", desc = "+ai(Avante)", mode = { "n", "v" } },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    --"echasnovski/mini.icons", -- or nvim-tree/nvim-web-devicons
    --"zbirenbaum/copilot.lua", -- for providers='copilot'
    "ravitemer/mcphub.nvim", -- for mcphub server
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      ft = function(_, ft)
        vim.list_extend(ft, { "Avante" })
      end,
      opts = function(_, opts)
        opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
      end,
    },
  },
}
