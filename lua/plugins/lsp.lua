return {
  "neovim/nvim-lspconfig",
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
