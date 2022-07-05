# fushin

<a alt=nimble-directory href=https://nimble.directory/pkg/fushin>
  <img height=20 src=https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png />
</a> <a alt=doc href=https://egpl.ga/fushin/fushin.html>
  <img src=https://github.com/eggplants/fushin/actions/workflows/pages/pages-build-deployment/badge.svg />
</a>

[![pre-commit.ci status](
  https://results.pre-commit.ci/badge/github/eggplants/fushin/master.svg
  )](
  https://results.pre-commit.ci/latest/github/eggplants/fushin/master
) [![release](
  https://github.com/eggplants/fushin/actions/workflows/release.yml/badge.svg
  )](
  https://github.com/eggplants/fushin/actions/workflows/release.yml
) [![GitHub release (latest SemVer)](
  https://img.shields.io/github/v/release/eggplants/fushin?logo=github&sort=semver
  )](
  https://github.com/eggplants/fushin/releases
)

<!--

[![PyPI](https://img.shields.io/pypi/v/fushin?color=blue)](https://pypi.org/project/fushin)

-->

<https://fushinsha-joho.co.jp/serif.cgi> Downloader

Fetch fushinsha serif data and save as csv files.

## Install

<!--

### From Binary

See: Releases

-->

### From Nim Packages

```bash
nimble install fushin
```

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
