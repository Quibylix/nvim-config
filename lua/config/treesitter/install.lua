local M = {}

local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
local cache_dir = vim.fn.stdpath("cache") .. "/tree-sitter-src"

function M.update(parsers)
  vim.fn.mkdir(parser_dir, "p")
  vim.fn.mkdir(cache_dir, "p")

  local compiler = "tree-sitter"

  if vim.fn.executable(compiler) == 0 then
    vim.notify("[Treesitter] Tree-sitter cli not found.", vim.log.levels.ERROR)
    return
  end

  local is_windows = vim.uv.os_uname().sysname:find("Windows") ~= nil
  local ext = is_windows and "dll" or "so"

  for lang, config in pairs(parsers) do
    local repo_dir = cache_dir .. "/" .. lang
    local location = config.location or ""
    local location_dir = repo_dir .. location
    local output_file = parser_dir .. "/" .. lang .. "." .. ext

    if vim.fn.filereadable(output_file) == 1 then
      goto continue
    end

    local git_cmd
    if vim.fn.isdirectory(repo_dir) == 1 then
      git_cmd = { "git", "-C", repo_dir, "pull", "--quiet" }
    else
      git_cmd = { "git", "clone", "--depth", "1", config.url, repo_dir, "--quiet" }
    end

    local git_res = vim.system(git_cmd, { text = true }):wait()
    if git_res.code ~= 0 then
      vim.notify("[Treesitter] Error getting " .. lang .. ": " .. (git_res.stderr or ""), vim.log.levels.ERROR)
      goto continue
    end

    local compile_cmd = { compiler, "build", location_dir }

    table.insert(compile_cmd, "-o")
    table.insert(compile_cmd, output_file)

    local comp_res = vim.system(compile_cmd, { text = true }):wait()
    if comp_res.code ~= 0 then
      vim.notify("[Treesitter] Error compiling " .. lang .. ": " .. (comp_res.stderr or ""), vim.log.levels.ERROR)
    else
      vim.notify("[Treesitter] '" .. lang .. "' updated.", vim.log.levels.INFO)
    end

    ::continue::
  end
end

return M
