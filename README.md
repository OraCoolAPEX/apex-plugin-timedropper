# APEX Time Dropper

[![APEX Community](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/78c5adbe/badges/apex-community-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)
[![APEX Plugin](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/b7e95341/badges/apex-plugin-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)
[![APEX 5.1](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/88f0a6ed/badges/apex-5_1-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)
[![APEX Built with Love](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/7919f913/badges/apex-love-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)

An Oracle APEX Item Plug-in based on the jQuery UI timepicker Timedropper1.

## Demo

[Run Demo](https://apex.oracle.com/pls/apex/f?p=OraCoolAPEX:9)

## Preview

![Preview](/preview.gif?raw=true "Preview")

### Component-Level Custom Attributes

* Set Current Time: Automatically set current time by default. If set "false", the input "value" attribute is considered as main time value (`Default: true`).

### Application-Level Custom Attributes

* Auto Switch: Automatically change hour-minute or minute-hour on mouseup/touchend (`Default: false`).
* Meridians: Set time in 12-hour clock in which the 24 hours of the day are divided into two periods (`Default: false`).
* Format: A time format string that timeDropper expects existing values to be in and will write times out it (`Default: h:mm a`).

| Value | Description                      | Result |
|-------|----------------------------------|--------|
| H     | 24-hour format non-padded number | 0-24   |
| h     | 12-hour format non-padded number | 1-12   |
| HH    | 24-hour format padded number     | 00-24  |
| hh    | 12-hour format padded number     | 01-12  |
| m     | Non-padded numeric minutes       | 1-59   |
| mm    | padded numeric minutes           | 01-59  |
| a     | lower case meridian              | am-pm  |
| A     | upper case meridian              | AM-PM  |
* Mouse Wheel: Enables time change using mousewheel (`Default: false`).
* Init Animation: Animation Style to use when init timedropper (`Default: fadeIn`).

| Options    |
|------------|
| Fade In    |
| Drop Down  |
* Theme: Set the name of style that you have assigned on the stylesheet generated by the theme generator.

| Options    |
|------------|
| Vita       |
| Vita-Dark  |
| Vita-Red   |
| Vita-Slate |

## Versioning

[Semantic Versioning](https://semver.org/)

(`MAJOR.MINOR.PATCH`)

* MAJOR version increments when breaking backwards compatibility
* MINOR version increments when adding new functionality in a backwards-compatible manner
* PATCH version increments when fixing bugs and other miscellaneous changes

## License

![MIT](/LICENSE)