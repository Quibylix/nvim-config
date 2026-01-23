return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.4.0",
  opts = {
    hint = "floating-letter"
  },
  keys = {
    {
      "<leader>pw",
      function()
        local window_picker = require("window-picker")
        local picked_window_id = window_picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Pick a window",
    },
  }
}
