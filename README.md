<div align="center">
    <h1 align="center">base16-concfg</h1>
</div>

The real Chris Kempson's [base16](https://github.com/chriskempson/base16)
for [concfg](https://github.com/lukesampson/concfg).

concfg is an utility to import and export Windows console settings bundled with
[Scoop](https://github.com/lukesampson/scoop), a command-line installer
for Windows created by Luke Sampson.

**NOTE:** All presets in this repository are generated by a base16-builder,
I use [base16-builder-python].

About the Color Mapping
-----------------------

Windows Console (ConHost.exe) only use 16 colors palette,
therefore [base16](http://chriskempson.com/projects/base16/),
which is based on 16 colors, is a good theme solution for ConHost.

Before appling base16 themes, we should know that there are color mapping
difference between Windows Console and other terminals or applications.
The order of `ColorTable` of Windows Console doesn't map the [ANSI escape color], explained [here].
We need to remapping it manually. Here is the mapping table.

| ANSI/VT name   | ANSI/VT FG Code* | ANSI/VT BG Code | cmd.exe      | PowerShell  | ColorTable |
|----------------|------------------|-----------------|--------------|-------------|------------|
| Black          | \`e[30m          | \`e[40m         | Black        | Black       | 00         |
| Red            | \`e[31m          | \`e[41m         | Red          | DarkRed     | 04         |
| Green          | \`e[32m          | \`e[42m         | Green        | DarkGreen   | 02         |
| Yellow         | \`e[33m          | \`e[43m         | Yellow       | DarkYellow  | 06         |
| Blue           | \`e[34m          | \`e[44m         | Blue         | DarkBlue    | 01         |
| Magenta        | \`e[35m          | \`e[45m         | Purple       | DarkMagenta | 05         |
| Cyan           | \`e[36m          | \`e[46m         | Aqua         | DarkCyan    | 03         |
| White          | \`e[37m          | \`e[47m         | White        | Gray        | 07         |
| Bright Black   | \`e[90m          | \`e[100m        | Gray         | DarkGray    | 08         |
| Bright Red     | \`e[91m          | \`e[101m        | Light Red    | Red         | 12         |
| Bright Green   | \`e[92m          | \`e[102m        | Light Green  | Green       | 10         |
| Bright Yellow  | \`e[93m          | \`e[103m        | Light Yellow | Yellow      | 14         |
| Bright Blue    | \`e[94m          | \`e[104m        | Light Blue   | Blue        | 09         |
| Bright Magenta | \`e[95m          | \`e[105m        | Light Purple | Magenta     | 13         |
| Bright Cyan    | \`e[96m          | \`e[106m        | Light Aqua   | Cyan        | 11         |
| Bright White   | \`e[97m          | \`e[107m        | Brigh tWhite | White       | 15         |

*Notice if you want to use ANSI Escape Sequences in Windows Console, you should know that
only Windows 10 v1511 (TH2, build 10586) or later support ANSI Escape Sequences.
See [details](https://stackoverflow.com/questions/16755142/how-to-make-win32-console-recognize-ansi-vt100-escape-sequences).

So if you want to change the `Red` color of Windows Console (or `DarkRed` of PowerShell),
you should modify `ColorTable[04]` instead of `ColorTable[01]`. This is very important,
wrong color mapping could make your theme looks bad. To determine that if a theme's
color mapping is correct, run `git diff` in a dirty it directory, and see
the diff result. Normally the diff colors should be `Red` and `Green`.

### About command line token colors

Since PowerShell 5, the new [PSReadline] brings command line tokens colors feature,
the token (e.g. String, Parameter) of command line has its own color, execute
`Get-PSReadlineOption` in PowerShell then you will see some attributes like
`KeywordForegroundColor`, `ParameterForegroundColor`, and they have default values.

**Base16 redefined the 16 colors palette** (it only provides 8 actual colors and 8 shades of grey),
so after using a base16 theme, `Red2Red` or `BrightMagenta2BrightMagenta` become false. `ColorTable[12]`(`Red` of PowerShell)
can be a `orange (#ff9f43)` color in `base16-snazzy` or a `pink` color in another base16 theme,
or even grayscale (*In Base16, colors base00 to base07 are typically variations of a shade and run from darkest to lightest.*). The 16 colors of Windows Console are **HEAVILY CHANGED** after importing base16 themes,
and affects the command line tokens colors. Base16 themes break the color mapping,
and cause bad readability to commands, there is a discussion [here](https://github.com/lukesampson/concfg/issues/10).

But we still want to use base16 themes, since is a very cool architecture for building themes.
To solve the readability issue, we have to use [Set-PSReadlineOption]
to remapping the command line tokens colors to match base16 theme. Below are two screenshots
show the difference after remapping command line tokens colors (see those two commands).

| Default token colors in base16-tomorrow-night | Remapped token colors in base16-tomorrow-night  |
|----------------------|-----------------------|
| ![without-token-color-mapping.png](docs/without-token-color-mapping.png) | ![with-token-color-mapping.png](docs/with-token-color-mapping.png) |

I wrote a powershell script to do this job, you can take a look at [`command-line-token-color-mapping.ps1`](scripts/command-line-token-color-mapping.ps1) in the scripts directory for details.

**P.S.**: the script has been [integrated](https://github.com/lukesampson/concfg/pull/46) into [concfg](https://github.com/lukesampson/concfg), you could use `concfg tokencolor` command to set up the command line token colors.

**NOTE**: If you removed base16 themes from your Windows Console, you should also change the command line tokens colors back. Otherwise it may causes a bad look for your console.

Build
-----

1. Install build tool, for example:

``` powershell
pip install pybase16-builder
```

2. Create workspace and clone base16 sources, follow [base16-builder-python] build guides.

Usage
-----

Quick start example:

1. color scheme
``` powershell
concfg import https://raw.githubusercontent.com/chawyehsu/base16-concfg/master/presets/base16-solarized-dark.json
```

2. some opinioned settings (optional)
``` powershell
concfg import https://raw.githubusercontent.com/chawyehsu/base16-concfg/master/presets/basic.json
```

For advanced usage, please follow [concfg](https://github.com/lukesampson/concfg) guide/help to import presets.

``` powershell
concfg help
```

License
-------

**base16-concfg** © [Chawye Hsu](https://github.com/chawyehsu). Released under the [MIT](LICENSE) license.

> [Blog](https://chawyehsu.com) · GitHub [@chawyehsu](https://github.com/chawyehsu) · Twitter [@chawyehsu](https://twitter.com/chawyehsu)

[Set-PSReadlineOption]: https://docs.microsoft.com/en-us/powershell/module/psreadline/Set-PSReadlineOption
[PSReadline]: https://docs.microsoft.com/en-us/powershell/module/psreadline/
[base16-builder-python]: https://github.com/InspectorMustache/base16-builder-python
[ANSI escape color]: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
[here]: https://github.com/dotnet/corefx/blob/5e36ca02d2594f715da829aafaf7af2b554dfcdf/src/System.Console/src/System/ConsolePal.Unix.cs#L577-L603
[base16 styling guidelines]: https://github.com/chriskempson/base16/blob/master/styling.md
