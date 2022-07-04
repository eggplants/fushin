import fushinpkg/submodule

import std/os
import std/strformat
import std/strutils
import std/sequtils
import std/tables

import cligen

const
  Help = {"beginYear": "the beginning year", "endYear": "the ending year",
      "saveDir": "the directory to save csv files",
      "printProgress": "print logs for progress"}.toTable()
  Short = {"beginYear": 'b', "endYear": 'e', "saveDir": 'd',
      "printProgress": 'p'}.toTable()

proc escapeString(s: string): string =
  ## Escape each csv values.
  let ss = s.replace("\"", "\"\"")
  if ss.contains({',', '\r', '\n', '"'}): '"' & ss & '"'
  else: ss

proc parser(beginYear: int = 2017, endYear: int, saveDir: string = "csv",
    printProgress: bool = true) =
  ## Fetch fushinsha serif data and save as csv files.
  ## Source: https://fushinsha-joho.co.jp/serif.cgi
  try:
    let items: FushinItems = getFushinSelifItems(beginYear, endYear, printProgress)
    for k, v in items:
      let filename = fmt"{k}.csv"
      createDir(saveDir)
      if printProgress: echo "writting: ", filename
      var fp = open(joinPath(saveDir, filename), fmWrite)
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

proc getVersion(): string =
  ## Get version from git/package cofiguration.
  ## If failed, returns "develop"
  when defined(versionGit):
    staticExec "git describe --tags HEAD"
  elif defined(versionNimble):
    const nimbleFile = staticRead "../fushin.nimble"
    nimbleFile.fromNimble "version"
  else:
    "develop"

proc main() =
  ## Main.
  dispatch(parser, help = Help, short = Short)
  clCfg.version = getVersion()

when isMainModule:
  main()
