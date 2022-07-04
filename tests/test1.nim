import unittest

import fushinpkg/submodule

test "fetch data of 2017 only":
  discard getFushinSelifItems(2017, 2017, false)
