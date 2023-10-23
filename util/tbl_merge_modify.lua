---Deep merges t2 into t1. MODIFIES t1!
---@param t1 table table to merge into
---@param t2 table table to merge from
---@return table t1 modified t1
local function tbl_merge_modify(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k]) == "table") then
      tbl_merge_modify(t1[k], v)
    else
      t1[k] = v
    end
  end
  return t1
end

return tbl_merge_modify
