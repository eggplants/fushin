import fushinpkg/submodule
import std/tables
import strformat
import csvtools

proc main() =
  try:
    let items: FushinItems = getFushinSelifItems()
    for k, v in items.mpairs:
      let filename = fmt"{k}.csv"
      echo "writting: ", filename
      v.writeToCsv(filename)
  except ValueError as e:
    stderr.write(e.msg)
    quit(QuitFailure)

when isMainModule:
  main()
