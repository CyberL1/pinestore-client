Tasks:clean()

Tasks:minify "minify" {
  input = "out/pinestore.lua",
  output = "out/pinestore"
}

Tasks:require "main" {
  input = "src",
  startup = "src/main.lua",
  output = "out/pinestore.lua"
}

Tasks:Task "build" { "clean", "minify" }

Tasks:Default "build"
