import std/os

# Package
version = "0.0.0"
author = "eggplants"
description = "Fetch fushinsha serif data and save as csv files"
license = "MIT"
srcDir = "src"
installExt = @["nim"]
bin = @["fushin"]

# Dependencies

requires "nim >= 1.6.6"
requires "nimquery >= 2.0.0"
requires "cligen >= 1.5.24"

task docs, "Generate documents":
  exec "nimble doc --index:on --project src/*.nim -o:docs"

task tests, "Run test":
  exec "testament p 'tests/test*.nim'"

task bundle, "Bundle resources for distribution":
  let
    bundleDir = bin[0] & "-v" & version
    binExt =
      when defined(windows):
        ".exe"
      else:
        ""
  mkDir(bundleDir)
  for b in bin:
    let src = joinPath(binDir, b & binExt)
    let dst = joinPath(bundleDir, b & binExt)
    cpFile(src, dst)
  for f in @["LICENSE", "README.md"]:
    cpFile(f, joinPath(bundleDir, f))
