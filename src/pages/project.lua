local arg = ...
local utils = require("src.utils")

local project = utils.getData("project/" .. arg[1]).project

local function drawProjectInfo()
  term.clear()
  term.setCursorPos(1, 1)

  print("Name:", project.name)
  print("By:", project.owner_name)
end

while true do
  drawProjectInfo()

  local event, key = os.pullEvent("key")

  if keys.getName(key) == "enter" then
    utils.openPage("projects")
    break
  end
end
