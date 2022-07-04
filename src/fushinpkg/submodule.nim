import options
import xmltree
import streams
import htmlparser
import std/strtabs
import std/os
import std/strutils
import std/tables
import strformat

import nimquery
import httpclient


type
  TargetNodes = enum
    tFirst
    tSecond
    tThird
    tOther
  Ym = string
  FushinItem = tuple
    situation: string
    serif: string
    location: string
    category: string
    date: string
  FushinItems* = TableRef[submodule.Ym, seq[FushinItem]]

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
  let
    items: FushinItems = newTable[YM, seq[FushinItem]]()
  for year in beginYear..endYear:
    for month in 1..12:
      let ym = fmt"{year}{month:02}".YM
      if printProgress: echo fmt"{year}/{month}..."
      let
        html =
          fmt"{URL}?ym={ym}".getSource

      if html.checkResultExistence:
        return items
      items[ym] = @[]
      echo "parsing..."
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
      echo fmt"found: {len(items[ym])} items"
      sleep(1000)
    return items
