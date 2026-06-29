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

return server_config
