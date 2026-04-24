return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- -- Never set this value to "*"! Never!
    opts = {
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      mode = "agentic",
      provider = "copilot",
      -- provider = "gemini",
      auto_suggestions_provider = "siliconflow",
      providers = {
        gemini = {
          model = "gemini-3-flash-preview",
        },
        copilot = {
          model = "claude-haiku-4.5",
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
          model = "deepseek-ai/DeepSeek-V3",
        },
      },
      behaviour = {
        auto_approve_tool_permissions = false,
      },
      windows = {
        width = 35,
        ask = {
          start_insert = false,
        },
      },
      mappings = {
        ask = "<leader>va",
        new_ask = "<leader>vn",
        zen_mode = "<leader>vz",
        edit = "<leader>ve",
        refresh = "<leader>vr",
        focus = "<leader>vf",
        stop = "<leader>vs",
        toggle = {
          default = "<leader>vt",
          debug = "<leader>vd",
          selection = "<leader>vC",
          suggestion = "<leader>vS",
          repomap = "<leader>vR",
        },
        jump = {
          next = "]j",
          prev = "[j",
        },
        sidebar = {
          close_from_input = {
            normal = "q",
          },
          prev_prompt = "[[",
          next_prompt = "]]",
        },
        files = {
          add_current = "<leader>vc", -- Add current buffer to selected files
          add_all_buffers = "<leader>vB", -- Add all buffer files to selected files
        },
        select_model = "<leader>v?", -- Select model command
        select_history = "<leader>vh", -- Select history command
        select_acp_model = "<leader>vM", -- Select ACP agent model
        select_acp_mode = "<leader>vm", -- Select ACP agent mode
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
      { "<leader>v", "", desc = "ai(Avante)", mode = { "n", "v" } },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "ravitemer/mcphub.nvim", -- for mcphub server
    lazy = true,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = function(_, ft)
      -- add Avante filetype to the list of supported filetypes
      vim.list_extend(ft, { "Avante" })
      return ft
    end,
  },
  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    lazy = true,
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
}
