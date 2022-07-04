# Package

version       = "0.0.0"
author        = "eggplants"
description   = "Fetch fushinsha serif data and save as csv files"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["fushin"]


# Dependencies

requires "nim >= 1.6.6"
requires "nimquery >= 2.0.0"
requires "cligen >= 1.5.24"

task docs, "Generate documents":
  exec "nimble doc --index:on --project src/*.nim -o:docs"

task tests, "Run test":
  exec "testament p 'tests/test*.nim'"
