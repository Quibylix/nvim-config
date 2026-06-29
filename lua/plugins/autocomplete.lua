return {
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },
    build = function()
      require('blink.cmp').build():pwait()
    end,
    opts = {
      keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = { border = "rounded" },
        documentation = {
          window = { border = "rounded" },
        },
      },
      snippets = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = 'inherit' },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          menu = { auto_show = true }
        },
      },
    },
  },
}
