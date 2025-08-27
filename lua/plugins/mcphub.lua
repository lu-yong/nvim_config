return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "Open MCPHub", icon = "󰐻 ", mode = { "n", "v" } },
      },
    },
  },
  {
    lazy = true,
    version = "*",
    "ravitemer/mcphub.nvim",
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
      auto_approve = true, -- auto approve all actions
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
        copilotchat = {
          enabled = false,
          convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
          convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
          add_mcp_prefix = false, -- Add "mcp_" prefix to function names
        },
      },
    },
    keys = {
      { "<leader>m", "<cmd>MCPHub<cr>", desc = "Open MCPHub", mode = { "n", "v" } },
    },
  },
  -- set mcp-hub extension for lualine
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    opts = function(_, opts)
      local lualine_x = {
        function()
          -- Check if MCPHub is loaded
          if not vim.g.loaded_mcphub then
            return "󰐻 -"
          end

          local count = vim.g.mcphub_servers_count or 0
          local status = vim.g.mcphub_status or "stopped"
          local executing = vim.g.mcphub_executing

          -- Show "-" when stopped
          if status == "stopped" then
            return "󰐻 -"
          end

          -- Show spinner when executing, starting, or restarting
          if executing or status == "starting" or status == "restarting" then
            local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            local frame = math.floor(vim.loop.now() / 100) % #frames + 1
            return "󰐻 " .. frames[frame]
          end

          return "󰐻 " .. count
        end,
        color = function()
          if not vim.g.loaded_mcphub then
            return { fg = "#6c7086" } -- Gray for not loaded
          end

          local status = vim.g.mcphub_status or "stopped"
          if status == "ready" or status == "restarted" then
            return { fg = "#50fa7b" } -- Green for connected
          elseif status == "starting" or status == "restarting" then
            return { fg = "#ffb86c" } -- Orange for connecting
          else
            return { fg = "#ff5555" } -- Red for error/stopped
          end
        end,
      }
      table.insert(opts.sections.lualine_x, 2, lualine_x)
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}
