-- Visual
vim.o.relativenumber = true
vim.o.number = true;
vim.o.wrap = false

-- Indentation
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Maps
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>Q", ":q!<cr>")
vim.keymap.set("n", "<leader>cw", function()
  vim.o.wrap = not vim.o.wrap
end)

-- Filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.env.*", ".env" },
  callback = function()
    vim.bo.filetype = "env"
  end
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
    border = "rounded",
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end
  }
})

-- By default, in some projects, the backup copy is created by renaming the original file
-- This can be a problem when using a file watcher, so we can change the behavior to create a copy of the file
-- This way, the file watcher will not be triggered when the file is saved
-- Backup copy
vim.o.backupcopy = "yes"

require("config.lazy")
require("config.diagnostics")
require("config.treesitter")
