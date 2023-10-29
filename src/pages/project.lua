local arg = ...
local utils = require("src.utils")

local project = utils.getData("project/" .. arg[1]).project

local function drawProjectInfo()
  term.clear()
  term.setCursorPos(1, 1)

  print(project.name .. " - " .. project.owner_name)
  print()
  print("Install")
  print()
  print(project.description)
end

while true do
  drawProjectInfo()

  local event, key = os.pullEvent("key")

  if keys.getName(key) == "enter" then
    utils.install(project)
    break
  end

  if keys.getName(key) == "backspace" then
    utils.openPage("projects")
    break
  end
end
