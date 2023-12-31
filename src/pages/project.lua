local arg = ...

local utils
if oldRequire then
  utils = require("src.utils")
else
  utils = require("utils")
end

local project = utils.getData("project/" .. arg[1]).project

local function drawProjectInfo()
  term.clear()
  term.setCursorPos(1, 1)

  print(project.name .. " - " .. project.owner_name)
  print()
  print("Press enter to install")
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
