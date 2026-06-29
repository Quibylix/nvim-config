return {
  {
    "windwp/nvim-autopairs",
    opts = {}
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_rename = false,
        enable_close_on_slash = true,
      }
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_keymap('n', 's', '<Plug>(nvim-surround-normal)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', 's', '<Plug>(nvim-surround-visual)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'sd', '<Plug>(nvim-surround-delete)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'sc', '<Plug>(nvim-surround-change)', { noremap = true, silent = true })
    end,
  }
}
