# base16-concfg

> Base16 color schemes for Windows Console (concfg/conhost.exe/cmd.exe/PowerShell/OpenConsole.exe)

[![cicd][cicd-badge]][cicd] [![license][license-badge]](LICENSE)

[concfg] is an utility for importing and exporting [Windows Console] settings
written in PowerShell. This repository provides a collection of presets, driven by
the [Base16] specification, that can be used with concfg to import color schemes
into the Windows Console.

## Getting Started

Prerequisites:

- Windows OS and you're using the [Windows Console]
  - cmd.exe, powershell.exe, etc., that use `ConsoleHost` as the terminal
  - Windows Terminal doesn't benefit from this as it's newly designed and has its
    own settings for colors
  - Enhanced ConsoleHost like `ConEmu` or `Cmder` doesn't benefit from this
    either, as they have their own color settings
- [concfg] installed
  - PowerShell 5.1 or later
  - concfg was created as a compainion to [Scoop], you may install it via `scoop install concfg`

After you have installed concfg, you can import and use the presets in this repository.

``` powershell
concfg import https://raw.githubusercontent.com/chawyehsu/base16-concfg/master/presets/base16-snazzy.json
```

Please refer to the concfg documentation for more information on how to use it.

``` powershell
concfg help
```

## Development

Preqrequisites: Git, Rust toolchain

Presets in this repository are generated by the [tinted-builder-rust] builder
though only the base16 spec is supported in this repository.

1. Install build tool:

   ``` powershell
   cargo install tinted-builder-rust
   ```

2. Generate presets:

   ``` powershell
   tinted-builder-rust build . --sync
   ```

## Knowledge

### Color mapping

Windows Console (ConHost.exe) only use 16 colors palette, therefore [Base16], which
based on 16 colors, is a very good theme solution for ConHost.

Before utilizing base16 themes, one should know that there are color mapping
difference between Windows Console and other ANSI-based terminals (e.g. *nix terminals).
The main issue is the order of `ColorTable` of Windows Console **does not** map
the [ANSI escape color], explained [here]. Because of this, we need to remapping
it manually. Here is the mapping table.

_Please consider citing the source if you use this table in your project:_

| ANSI/VT Color  | ANSI/VT FG Code | ANSI/VT BG Code | cmd.exe*     | PowerShell**  | ColorTable | ConHost semantics |
|----------------|-----------------|-----------------|--------------|---------------|------------|-------------------|
| Black          | \`e[30m         | \`e[40m         | Black        | Black         | 00         | Screen Background |
| Red            | \`e[31m         | \`e[41m         | Red          | DarkRed       | 04         |                   |
| Green          | \`e[32m         | \`e[42m         | Green        | DarkGreen     | 02         |                   |
| Yellow         | \`e[33m         | \`e[43m         | Yellow       | DarkYellow    | 06         |                   |
| Blue           | \`e[34m         | \`e[44m         | Blue         | DarkBlue      | 01         |                   |
| Magenta        | \`e[35m         | \`e[45m         | Purple       | DarkMagenta   | 05         | Popup Text        |
| Cyan           | \`e[36m         | \`e[46m         | Aqua         | DarkCyan      | 03         |                   |
| White          | \`e[37m         | \`e[47m         | White        | Gray          | 07         | Screen Text       |
| Bright Black   | \`e[90m         | \`e[100m        | Gray         | DarkGray      | 08         |                   |
| Bright Red     | \`e[91m         | \`e[101m        | Light Red    | Red           | 12         |                   |
| Bright Green   | \`e[92m         | \`e[102m        | Light Green  | Green         | 10         |                   |
| Bright Yellow  | \`e[93m         | \`e[103m        | Light Yellow | Yellow        | 14         |                   |
| Bright Blue    | \`e[94m         | \`e[104m        | Light Blue   | Blue          | 09         |                   |
| Bright Magenta | \`e[95m         | \`e[105m        | Light Purple | Magenta       | 13         |                   |
| Bright Cyan    | \`e[96m         | \`e[106m        | Light Aqua   | Cyan          | 11         |                   |
| Bright White   | \`e[97m         | \`e[107m        | Bright White | White         | 15         | Popup Background  |

_* you can type `color /?` in cmd.exe to view the naming definition._  
_** you can type `[Enum]::GetValues([System.ConsoleColor])` to enumerate the color names in powershell._

Note that the ANSI Escape Sequences support in Windows Console is only available
on Windows 10 v1511 (TH2, build 10586) or above, see this [post].

Now you want to change the `Red` color of cmd.exe (or `DarkRed` of PowerShell),
you need to modify `ColorTable[04]` instead of `ColorTable[01]`. This is the key,
using a wrong color mapping could make your color scheme looks terrible.

To determine that if a color scheme's color mapping works correctly, you may run
`git diff` in a dirty git directory and see the diff result. Normally there should
only be red and green colors in the diff result.

### Optional token colors remapping

Since PowerShell 5, [PSReadline] brings command line tokens colors feature,
tokens (e.g. String, Parameter) of command line get their own colors. Run
`Get-PSReadlineOption` in PowerShell then you will see some attributes like
`KeywordForegroundColor`, `ParameterForegroundColor`. These attributes are
used to set the colors of command line tokens.

When using base16 color schemes in Windows Console, the command line tokens colors
sometimes may not look good because of the spec limitations of Base16 (it can only
use 8 colors and 8 shades of grey, and it redefined the colors palette led to a
significant color mapping difference - e.g. `Red` of PowerShell may not be a red
color anymore).

While some users might not notice the token colors, in order to address this issue,
[Set-PSReadlineOption] may be used to remap the command line tokens colors to match
the base16 theme. Below are two screenshots showing the difference after remapping
command line tokens colors (see those two commands).

**Example** (using the `base16-tomorrow-night` theme):

| Default token colors               | Remapped token colors           |
|------------------------------------|---------------------------------|
| ![without-token-color-mapping.png] | ![with-token-color-mapping.png] |

I've created a PowerShell script to make it easier to do this job, you can take
a look at [`tokencolor.ps1`] in the scripts directory of this repository. The
script has been [integrated] into concfg so it is also available via `concfg tokencolor`.

Token colors remapping is optional, you can choose to use it or not. But if you
switched to another theme that is not base16 based, you probably need to disable
the token colors remapping. Otherwise it may result in a weird looking console.

## License

**base16-concfg** © [Chawye Hsu](https://github.com/chawyehsu). Released under the [MIT](LICENSE) license.

> [Blog](https://chawyehsu.com) · GitHub [@chawyehsu](https://github.com/chawyehsu) · Twitter [@chawyehsu](https://twitter.com/chawyehsu)

[cicd-badge]: https://img.shields.io/github/actions/workflow/status/chawyehsu/base16-concfg/update.yml?style=flat&logo=github&logoColor=FFFFFF&colorA=121212&colorB=007EC6
[cicd]: https://github.com/chawyehsu/base16-concfg/actions/workflows/update.yml
[license-badge]: https://img.shields.io/github/license/chawyehsu/base16-concfg?style=flat&logo=spdx&logoColor=FFFFFF&colorA=121212&colorB=007EC6
[concfg]: https://github.com/lukesampson/concfg
[Windows Console]: https://en.wikipedia.org/wiki/Windows_Console
[Base16]: https://github.com/chriskempson/base16
[Scoop]: https://scoop.sh/
[Set-PSReadlineOption]: https://docs.microsoft.com/en-us/powershell/module/psreadline/Set-PSReadlineOption
[post]: https://stackoverflow.com/questions/16755142/how-to-make-win32-console-recognize-ansi-vt100-escape-sequences
[PSReadline]: https://docs.microsoft.com/en-us/powershell/module/psreadline/
[tinted-builder-rust]: https://github.com/tinted-theming/tinted-builder-rust
[ANSI escape color]: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
[here]: https://github.com/dotnet/corefx/blob/5e36ca02d2594f715da829aafaf7af2b554dfcdf/src/System.Console/src/System/ConsolePal.Unix.cs#L577-L603
[without-token-color-mapping.png]: resources/without-token-color-mapping.png
[with-token-color-mapping.png]: resources/with-token-color-mapping.png
[`tokencolor.ps1`]: resources/tokencolor.ps1
[integrated]: https://github.com/lukesampson/concfg/pull/46
