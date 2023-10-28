local utils = {}

function utils.getData(endpoint)
  local res = http.get(endpoint)
  if not res then
    print("Failed to GET " .. endpoint)
    return
  end

  local data = res.readAll()
  res.close()
  return textutils.unserializeJSON(data)
end

function utils.drawProjects(projects, currentProject)
  term.setCursorPos(1, 1)

  for i = 1, #projects do
    if i == currentProject then
      term.setTextColor(colors.blue)
    else
      term.setTextColor(colors.gray)
    end

    local str = i .. ". " .. projects[i].name
    local x, y = term.getCursorPos()

    print(str)
  end
  term.setTextColor(colors.white)
end

return utils
