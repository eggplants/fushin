# Package

version       = "0.1.0"
author        = "eggplants"
description   = "Create fushin DB"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["fushin"]


# Dependencies

requires "nim >= 1.6.6"
requires "nimquery >= 2.0.0"
requires "csvtools >= 0.2.1"
