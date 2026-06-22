local init = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local cmp_enter_mapping = cmp.mapping(function(fallback)
    if cmp.visible() == false then
      fallback()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif cmp.get_active_entry() then
      cmp.confirm({ select = false })
    else
      fallback()
    end
  end)

  local cmp_tab_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    else
      fallback()
    end
  end, { "i", "s" })

  local cmp_s_tab_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    else
      fallback()
    end
  end, { "i", "s" })

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For Luasnip
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<cr>"] = cmp_enter_mapping,
      ["<tab>"] = cmp_tab_mapping,
      ["<s-tab>"] = cmp_s_tab_mapping,
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- For luasnip users.
    }, {
      { name = "buffer" },
    })
  })
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" }
    }
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" }
    }, {
      { name = "cmdline" }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return {
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip", "neovim/nvim-lspconfig" },
    init = init,
  },
}
