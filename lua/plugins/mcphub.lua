return {
  lazy = false,
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    {
      "nvim-lualine/lualine.nvim",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, 2, require("mcphub.extensions.lualine"))
      end,
    },
  },
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
    },
  },
}
