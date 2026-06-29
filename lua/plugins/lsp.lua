return {
  {
    "hrsh7th/cmp-nvim-lsp",
    config = function()
      local server_config = require("config.server")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      for server_name, server_opts in pairs(server_config) do
        server_opts.capabilities = capabilities
        vim.lsp.config[server_name] = server_opts
        vim.lsp.enable(server_name)
      end

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.c", "*.cpp", "*.lua" },
        callback = function(args)
          vim.lsp.buf.format({ bufnr = args.buf, async = false })
        end
      })
    end
  },
  {
    "jinzhongjia/LspUI.nvim",
    event = "LspAttach",
    branch = "main",
    opts = {},
    keys = {
      { "<leader>rn", "<cmd>LspUI rename<cr>",      { "n", "v" } },
      { "K",          "<cmd>LspUI hover<cr>",       { "n", "v" } },
      { "<leader>ca", "<cmd>LspUI code_action<cr>", { "n", "v" } },
      { "<leader>rf", "<cmd>LspUI reference<cr>",   { "n", "v" } },
    },
    version = "a8f0720168e48561d0f22c418a225ca8933fc258"
  }
}
