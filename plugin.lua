local tbl_merge_modify = require("util.tbl_merge_modify")
local wezterm = require("wezterm")

-- allow calling the export (or export.plugin)
local M = {}
---calls M.plugin(...)
setmetatable(M, {
  __call = function(_, ...)
    return M.plugin(...)
  end,
})

-- Create config object
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder and wezterm.config_builder() or {}

local function merge_config(merge)
  return tbl_merge_modify(config, merge)
end

---Calls wezterm.log_error
local function log_err(msg, ...)
  return wezterm.log_error(string.format(msg, ...))
end

---@alias config table|fun(config: config): config
---recursively evaluate exported values
---@param export config?
---@param module string the path. used only for output
---@return table
local function get_from_export(export, module)
  local t_export = type(export)
  -- Nil means just continue
  if not export then return config end
  if t_export == "table" then -- If table, merge with config
    return merge_config(export)
  end

  -- If function, call with current config and recursively handle the result.
  if t_export == "function" then
    local suc, res = pcall(export, config)
    if not suc then -- Failed!
      log_err("Module plugins.%s threw error: %s", module, res)
      return config
    end
    --- Recursively handle allows it to return a fun():fun():fun()...
    --- Functions have no logical way to merge them, so we should just call indefinitely
    return get_from_export(res, module)
  end

  log_err("Found %s while evaluating plugins.%s, expected table or fun(c: table): config", type(export), module)
  return config
end

---Requires plugins.mod and merges the configuration with the returned table, or runs the returned function with the current configuration as an argument and merges the returned table. nil return values are ignored. If a table is passed, it's iterated (recursively) with ipairs and each module is required.
---@param mod string| string[] the module located under plugins to require
---@return table config current configuration (after merge)
function M.plugin(mod)
  -- If a table is passed in, call on each plugin.
  if type(mod) == "table" then
    for _, p in ipairs(mod) do
      M.plugin(p)
    end
    --- END! return the changed configuration
    return config
  end

  if type(mod) ~= "string" then
    log_err("plugin expected string, got %s", type(mod))
    return config
  end

  return M.merge_plugin(mod)
end

---Merge a plugin configuration with the current configuration
---@param plugin string
function M.merge_plugin(plugin)
  local suc, export = pcall(require, plugin)
  if not suc then
    log_err("require of '%s' failed: %s", plugin, export)
    return config
  end
  -- Returned true or nil, just ignore it.
  if not export or export == true then return config end

  if type(export) == "table" then
    -- This is permitted, but discouraged. Warn if top level is a table
    wezterm.log_warn(
      ("%s %s %s"):format(
        "Returning a table breaks things and should be avoided!",
        "Return a function that wraps your entire file instead.",
        "See: https://github.com/wez/wezterm/issues/2401"
      )
    )
  end

  return get_from_export(export, plugin)
end

---Read all files in ./plugins and requires them
---Note: this assumes that dir is in package.path! (ie, given ./plugins/file.lua, require('plugins.file') will succeed)
---Note: directoies MUST have an init.lua to be successfully loaded.
---@param dir string? the directory to check.
---@return table
function M.init(dir)
  local plugin_dir = dir or "plugins"
  local plugin_dir_path = plugin_dir:find("^/") and plugin_dir or ("%s/%s"):format(wezterm.config_dir, plugin_dir)

  local files = wezterm.read_dir(plugin_dir_path) ---@type string[]
  for _, abs_name in ipairs(files) do
    local name = tostring(abs_name):sub(plugin_dir_path:len() + 2, -5) -- remove plugin_dir/ and .lua from name. Note: 1-based indexing...
    if name:find("%.") then
      wezterm.log_warn(("Lua filenames can not contain '.': %s"):format(abs_name))
    else
      M.merge_plugin(("%s.%s"):format(plugin_dir, name:gsub("/", ".")))
    end
  end
  return config
end

return M
