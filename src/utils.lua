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

return utils
