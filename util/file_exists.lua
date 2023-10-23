---checks if a file exists on the filesystem (is readable to current user)
---@param name string path to the file (relative to CWD)
---@return boolean file is readable
local function file_exists(name)
  local f = io.open(name, "r")
  if f then f:close() end
  return f ~= nil
end

return file_exists
