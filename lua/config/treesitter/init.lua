local language_parsers = {
  c = { url = "https://github.com/tree-sitter/tree-sitter-c" },
  lua = { url = "https://github.com/tree-sitter-grammars/tree-sitter-lua" },
  vim = { url = "https://github.com/tree-sitter-grammars/tree-sitter-vim" },
  vimdoc = { url = "https://github.com/neovim/tree-sitter-vimdoc" },
  javascript = { url = "https://github.com/tree-sitter/tree-sitter-javascript" },
  html = { url = "https://github.com/tree-sitter/tree-sitter-html" },
  typescript = { url = "https://github.com/tree-sitter/tree-sitter-typescript", location = "/typescript" },
  tsx = { url = "https://github.com/tree-sitter/tree-sitter-typescript", location = "/tsx" },
  cpp = { url = "https://github.com/tree-sitter/tree-sitter-cpp" },
  json = { url = "https://github.com/tree-sitter/tree-sitter-json" },
  yaml = { url = "https://github.com/tree-sitter-grammars/tree-sitter-yaml" },
  go = { url = "https://github.com/tree-sitter/tree-sitter-go" },
}

vim.treesitter.language.register("bash", { "env" })
vim.treesitter.language.register("tsx", { "typescriptreact" })
vim.treesitter.language.register("javascript", { "javascriptreact", "ecma", "ecmascript", "jsx", "js" })

require("config.treesitter.install").update(language_parsers)

local ts_group = vim.api.nvim_create_augroup("NativeTreesitterSetup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf

    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))

    if ok and stats and stats.size > max_filesize then
      vim.cmd("syntax off")
      pcall(vim.treesitter.stop, bufnr)
      return
    end

    local ft = vim.bo[bufnr].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if lang then
      pcall(vim.treesitter.start, bufnr, lang)
      vim.bo.indentexpr = "v:lua.require'config.treesitter.indent'.indentexpr()"
    end
  end,
})
