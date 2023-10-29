Tasks:clean()

Tasks:minify "minify" {
  input = "out/pinestore.lua",
  output = "out/pinestore"
}

Tasks:require "main" {
  include = "src",
  startup = "src/main.lua",
  output = "out/pinestore.lua"
}

Tasks:Task "build" { "clean", "minify" } :Description "Builds application"

Tasks:Default "build"
