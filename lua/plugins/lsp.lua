return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "gr", vim.lsp.buf.references, desc = "References", nowait = true, has = "references" }
    keys[#keys + 1] = { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition", has = "type_definition" }
  end,
}
