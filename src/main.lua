local endpoints = require("endpoints")
local utils = require("utils")

term.clear()

local projects = utils.getData(endpoints.projects).projects
local selectedProject = 1

utils.drawProjects(projects, selectedProject)
