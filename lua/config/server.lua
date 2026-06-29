local server_config = {
  clangd = {
    inlay_hints = false,
    filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
    cmd = {
      "clangd",
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT"
        },
        diagnostics = {
          globals = { "vim" }
        },
        workspace = {
          library = { vim.env.VIMRUNTIME }
        }
      }
    }
  },
  ts_ls = {},
  html = {},
  cssls = {},
  pyright = {},
  biome = {},
  jsonls = {},
  prismals = {},
  gopls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
