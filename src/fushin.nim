import fushinpkg/submodule
import std/tables
import std/strformat
import std/strutils
import std/sequtils

proc escapeString(s: string): string =
  let ss = s.replace("\"", "\"\"")
  if ss.contains({',', '\r', '\n', '"'}): '"' & ss & '"'
  else: ss

proc main() =
  try:
    let items: FushinItems = getFushinSelifItems(endYear=2017)
    for k, v in items:
      let filename = fmt"{k}.csv"
      echo "writting: ", filename
      var fp = open(filename, fmWrite)
      defer:
        fp.close()

      fp.writeLine("situation,serif,location,category,date")
      for item in v:
        let row = [item.situation, item.serif, item.location, item.category, item.date]
        let escaped = row.map(escapeString)
        for i, v in escaped:
          if i < 4:
            fp.write(v & ',')
          else:
            fp.writeLine(v)
  except ValueError as e:
    stderr.write(e.msg)
    quit(QuitFailure)

when isMainModule:
  main()
