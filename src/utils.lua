local utils = {}

function utils.getData(path)
  local res = http.get("https://pinestore.cc/api/" .. path)
  if not res then
    print("Failed to GET https://pinestore.cc/api/" .. path)
    return
  end

  local data = res.readAll()
  res.close()
  return textutils.unserializeJSON(data)
end

function utils.postData(path, data)
  local res = http.post("https://pinestore.cc/api/" .. path, textutils.serializeJSON(data),
    { ["Content-Type"] = "application/json" })
  if not res then
    print("Failed to POST https://pinestore.cc/api/" .. path)
    return
  end

  local data = res.readAll()
  res.close()
  return textutils.unserializeJSON(data)
end

function utils.openPage(page, ...)
  local fn = preload["src.pages." .. page](arg)
  local ok, err = pcall(fn)

  if not ok then
    term.setTextColor(colors.red)
    print(err)
    term.setTextColor(colors.white)
  end
end

function utils.install(app)
  local appDir = "apps/" .. app.id .. "/"
  fs.makeDir(appDir)

  local originalFsOpen = fs.open
  local originalFsMakeDir = fs.makeDir
  local originalFsExists = fs.exists

  function fs.open(path, mode)
    if path:sub(1, 12) == "rom/programs" then
      return originalFsOpen(path, mode)
    end
    return originalFsOpen(appDir .. path, mode)
  end

  function fs.makeDir(path)
    if path:sub(1, 12) == "rom/programs" then
      return originalFsMakeDir(path)
    end
    return originalFsMakeDir(appDir .. path)
  end

  function fs.exists(path)
    if path:sub(1, 12) == "rom/programs" then
      return originalFsExists(path)
    end
    return originalFsExists(appDir .. path)
  end

  local ok, err = xpcall(shell.run, debug.traceback, app.install_command)
  utils.postData("log/download", { projectId = app.id })

  if not ok then
    print(err)
  end

  fs.open = originalFsOpen
  fs.makeDir = originalFsMakeDir
  fs.exists = originalFsExists
end

return utils
