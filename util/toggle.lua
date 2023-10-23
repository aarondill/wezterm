---Use to toggle a variable in one line :)
---Usage: val = toggle(val, maybe_new_val)
---@generic T
---@param cval T?
---@param val T
---@return T?
local function toggle(cval, val)
  if cval == nil then return val end
  return nil
end

return toggle
