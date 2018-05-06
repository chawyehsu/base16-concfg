base16-concfg
=============

The real Chris Kempson's [base16](https://github.com/chriskempson/base16)
for [concfg](https://github.com/lukesampson/concfg),
which is utility to import and export Windows console settings bundled with
[Scoop](https://github.com/lukesampson/scoop),
a command-line installer for Windows created by Luke Sampson.

**NOTE:** All presets in this repository are generated by a base16-builder,
I use [base16-builder-typescript].

About the Color Mapping
-----------------------

Windows Console (conhost.exe/cmd.exe/Powershell) only use 16 colors palette,
therefore [base16](http://chriskempson.com/projects/base16/),
which is based on sixteen colours, would be the best themes solution.

But there are color mapping difference between Windows Console and other terminals or applications.
The colors of Windows Console doesn't map the [ANSI escape color] [^1].
We should treat those most `dark_` colors as major (normal) colors and 
other as minor (bright) colors.

| ANSI name      | cmd.exe      | PowerShell  | ColorTable |
|----------------|--------------|-------------|------------|
| Black          | Black        | Black       | 00         |
| Blue           | Blue         | DarkBlue    | 01         |
| Green          | Green        | DarkGreen   | 02         |
| Cyan           | Aqua         | DarkCyan    | 03         |
| Red            | Red          | DarkRed     | 04         |
| Magenta        | Purple       | DarkMagenta | 05         |
| Yellow         | Yellow       | DarkYellow  | 06         |
| White          | White        | Gray        | 07         |
| Bright Black   | Gray         | DarkGray    | 08         |
| Bright Blue    | Light Blue   | Blue        | 09         |
| Bright Green   | Light Green  | Green       | 0A         |
| Bright Cyan    | Light Aqua   | Cyan        | 0B         |
| Bright Red     | Light Red    | Red         | 0C         |
| Bright Magenta | Light Purple | Magenta     | 0D         |
| Bright Yellow  | Light Yellow | Yellow      | 0E         |
| Bright White   | Brigh tWhite | White       | 0F         |

To determine that if a theme's color mapping is correct, execute `git diff` in
a dirty git directory, and see the diff result. **Might** correct if the diff colors are
red & green, otherwise incorrect definitely.

### About command line token colors

Since PowerShell 5, the new [PSReadline] brings command line tokens colours feature,
the token (e.g. String, Parameter) of command line has its own color, execute
`Get-PSReadlineOption` in PowerShell then you will see some attributes like
`KeywordForegroundColor`, `ParameterForegroundColor`. They have default values,
but these values don't match the theme color mapping very well, and cause bad
readability to commands, there is a discussion [here](https://github.com/lukesampson/concfg/issues/10).

To improve the readability or the whole style of theming, we have to use [Set-PSReadlineOption]
to change the command line tokens colours. Below are two screenshots show the difference
(see those two commands). Take a look at `command-line-token-color-mapping.ps1` in the scripts
directory for more information.

| Default token colors | Matching token colors |
|----------------------|-----------------------|
| ![without-token-color-mapping.png](docs/without-token-color-mapping.png) | ![with-token-color-mapping.png](docs/with-token-color-mapping.png) |


Build
-----

1. Install build tool, for example:

``` powershell
yarn global add base16-builder-typescript
```

2. Create workspace and clone base16 sources, follow [base16-builder-typescript] build guides.

Usage
-----

Please follow [concfg](https://github.com/lukesampson/concfg) guide to import presets. for example:

``` powershell
concfg import https://raw.githubusercontent.com/h404bi/base16-concfg/master/presets/base16-solarized-dark.json
```

License
-------

MIT

[Set-PSReadlineOption]: https://docs.microsoft.com/en-us/powershell/module/psreadline/Set-PSReadlineOption
[PSReadline]: https://docs.microsoft.com/en-us/powershell/module/psreadline/
[base16-builder-typescript]: https://github.com/golf1052/base16-builder-typescript
[ANSI escape color]: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
[^1]: https://github.com/dotnet/corefx/blob/5e36ca02d2594f715da829aafaf7af2b554dfcdf/src/System.Console/src/System/ConsolePal.Unix.cs#L578-L580
[base16 styling guidelines]: https://github.com/chriskempson/base16/blob/master/styling.md
