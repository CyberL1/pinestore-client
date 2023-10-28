local endpoints = require("endpoints")
local utils = require("utils")

local projects = utils.getData(endpoints.projects).projects

for i = 1, #projects do
  local project = projects[i]
  print(i .. ". " .. project.name .. " by " .. project.owner_name)
end
