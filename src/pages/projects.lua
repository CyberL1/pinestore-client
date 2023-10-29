local utils = require("utils")

local projects = utils.getData("projects").projects
local selectedProject = 1

local pageSize = 5
local currentPage = 1
local currentPageStart = 1
local currentPageEnd = pageSize

local function drawProjects()
  term.clear()
  term.setCursorPos(1, 1)

  for i = 1, pageSize do
    local itemIndex = i + (currentPage - 1) * pageSize
    if projects[itemIndex] then
      if selectedProject == itemIndex then
        term.setTextColor(colors.blue)
      else
        term.setTextColor(colors.gray)
      end
      print(projects[itemIndex].name)
    else
      break
    end
  end
  term.setTextColor(colors.white)
  print("Selected project " .. selectedProject .. " of " .. #projects)
end

while true do
  drawProjects()

  local event, key = os.pullEvent("key")

  if keys.getName(key) == "up" then
    if selectedProject == currentPageStart and currentPage > 1 then
      currentPage = currentPage - 1
      currentPageStart = currentPageStart - pageSize
      currentPageEnd = currentPageEnd - pageSize
    end

    if selectedProject > 1 then
      selectedProject = selectedProject - 1
    end
  elseif keys.getName(key) == "down" then
    if selectedProject == currentPageEnd and selectedProject < #projects then
      currentPage = currentPage + 1
      currentPageStart = currentPageStart + pageSize
      currentPageEnd = currentPageEnd + pageSize
    end

    if selectedProject < #projects then
      selectedProject = selectedProject + 1
    end
  end

  if keys.getName(key) == "enter" then
    utils.openPage("project", projects[selectedProject].id)
    break
  end
end
