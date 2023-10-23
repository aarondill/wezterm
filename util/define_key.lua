---Return from plugin file to define a key shortcut.
---@param key {key:string, mods?:string|string[], action?:unknown}
---@return fun(config:table):nil
local function define_key(key)
  return function(config)
    if config.keys then
      config.keys[#config.keys + 1] = key
    else
      config.keys = { key }
    end
  end
end

return define_key
