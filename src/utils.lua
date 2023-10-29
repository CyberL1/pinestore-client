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

function utils.openPage(page, ...)
  local fn = preload["src.pages." .. page](arg)
  local ok, err = pcall(fn)

  if not ok then
    term.setTextColor(colors.red)
    print(err)
    term.setTextColor(colors.white)
  end
end

return utils
