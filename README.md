# fushin

<https://fushinsha-joho.co.jp/serif.cgi> Downloader

Fetch fushinsha serif data and save as csv files.

## Install

<!--

### From Binary

See: Releases

-->

### From GitHub

```bash
nimble install https://github.com/eggplants/fushin
```

### From Source

```bash
git clone https://github.com/eggplants/fushin && cd fushin && nimble install
```

## Usage

Try: `fushin -b 2017 -e 2022`

### Help

```shellsession
$ fushin -h
Usage:
  fushin [REQUIRED,optional-params]
Fetch fushinsha serif data and save as csv files.  (Source: https://fushinsha-joho.co.jp/serif.cgi)
Options:
  -h, --help                             print this cligen-erated help
  --help-syntax                          advanced: prepend,plurals,..
  -b=, --beginYear=    int     2017      the beginning year
  -e=, --endYear=      int     REQUIRED  the ending year
  -d=, --saveDir=      string  "csv"     the directory to save csv files
  -p, --printProgress  bool    true      print logs for progress
```

## License

MIT
