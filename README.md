Introduction
============

These are scripts for use on macOS to create DVDs.

Prerequisites
=============

```bash
brew install dvdauthor cdrtools ffmpeg
```

Contents
========

* `make_dvd` - Creates a DVD ISO
* `make_dvd_xml.rb` - Creates an XML control file for use with `dvdauthor`

`make_dvd`
==========

Usage:

```bash
make_dvd <iso_path> [media_files.mpg ...]
```

`make_dvd_xml.rb`
=================

Usage:

```bash
make_dvd_xml.rb [media_files.mpg ...]
```
