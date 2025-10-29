return {
  {
    "yetone/avante.nvim",
    opts = {
      providers = {
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
    keys = function()
      return {
        { "<leader>v", "", desc = "ai(Avante)", mode = { "n", "v" } },
        { "<leader>va", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
        { "<leader>vc", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
        { "<leader>ve", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
        { "<leader>vf", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
        { "<leader>vh", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
        { "<leader>vm", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
        { "<leader>vn", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
        { "<leader>vr", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
        { "<leader>vs", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
        { "<leader>vt", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
      }
    end,
  },
  {
    "ravitemer/mcphub.nvim", -- for mcphub server
    lazy = true,
  },
}
