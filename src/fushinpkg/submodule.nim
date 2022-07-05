import options
import xmltree
import streams
import htmlparser
import std/strtabs
import std/os
import std/strutils
import std/tables
import strformat

# import nimpy
import nimquery
import httpclient


type
  TargetNodes = enum
    ## classifiers for targetting node
    tFirst  ## Node for situation
    tSecond ## Node for serif
    tThird  ## Node for location/category/date
    tOther  ## Others
  Ym* = string
  ## Year & Month
  FushinItem* = tuple
    ## An item of Fushinsha information
    situation: string ## Situation in which fushinsha occurred
    serif: string ## Words uttered by fushinsha
    location: string ## Places where fushinsha has issued
    category: string ## Classification of fushinsha
    date: string ## Date fushinsha occurred
  FushinItems* = TableRef[submodule.Ym, seq[FushinItem]]
    ## An table of target year/month and fushinsha items

proc getSource(url: string): XmlNode =
  return
    newHttpClient()
    .get(url)
    .body
    .newStringStream()
    .parseHTML()

proc checkResultExistence(html: XmlNode): bool =
  let
    msg = option(html.querySelector("div[style=\"text-align: center;\"]"))

  return msg.isSome() and msg.get().innerText == "該当する不審者情報は未登録です"

proc classifyNodes(node: XmlNode): TargetNodes =
  if not node.attrs.hasKey("style"): return tOther
  case node.attrs["style"]
  of "font-size: 14px; line-height: 18px;":
    return tFirst
  of "margin-top: 4px; font-size: 24px; line-height: 28px; font-weight: bold;":
    return tSecond
  of "margin-top: 6px; font-size: 12px; line-height: 14px;":
    return tThird
  return tOther
const URL = "https://fushinsha-joho.co.jp/serif.cgi"


proc getFushinSelifItems*(beginYear: int = 2017, endYear: int = int.high,
    printProgress: bool = true): FushinItems =
  ## Get fushinsha serif data.
  ## Returns data as item.
  let
    items: FushinItems = newTable[YM, seq[FushinItem]]()
  for year in beginYear..endYear:
    for month in 1..12:
      let ym = fmt"{year}{month:02}".YM
      if printProgress:
        stdout.write fmt"{year}/{month}..."
        stdout.flushFile()
      let
        html =
          fmt"{URL}?ym={ym}".getSource

      if html.checkResultExistence:
        if printProgress: echo fmt"found: 0 items"
        return items
      items[ym] = @[]
      var currentItem: FushinItem
      for idx, d in html.findAll("div"):
        case d.classifyNodes
        of tOther:
          continue
        of tFirst:
          currentItem.situation = d.innerText.strip
        of tSecond:
          currentItem.serif = d.innerText.strip
        of tThird:
          let values = d.innerText.strip.split(" ", 2)
          if len(values) != 3:
            var e: ref ValueError
            new(e)
            e.msg = fmt"Invalid num of values -- {len(values)}"
            raise e
          currentItem.location = values[0]
          currentItem.category = values[1]
          currentItem.date = values[2]

          items[ym].add(currentItem)
      if printProgress: echo fmt"found: {len(items[ym])} items"
      sleep(5000)
  return items
