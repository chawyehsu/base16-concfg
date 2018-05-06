# NOTE: This script is used to set syntax highlighting colors
# of the PSReadline module, and affect the colors of command line
# (only command line tokens, not prompt). It"s an enhancement,
# not decisive factor to theming. The color of tokens is determined by
# what theme you use. If you use solorized_dark, this script will automatically
# use solorized_dark mapping colours to improve the colors of command line,
# make them easier to be recognized and looks better.
#
# Since we use base16 for building themes, we follow base16's styling
# guidelines(https://github.com/chriskempson/base16/blob/master/styling.md)
# to configure token colours, for example:
#   Keyword -> base0E
#   String  -> base0B
#
# To use this script, simply import the .ps1 script, or just
# copy below code into you your PowerShell profile. You have to install
# PSReadline module before you do it. If you are on Windows 10,
# PSReadLine is already installed. More information:
#   https://github.com/lzybkr/PSReadLine#installation

if (Get-Module -ListAvailable -Name "PSReadline") {
    # Reset
    Set-PSReadlineOption -ResetTokenColors

    $options = Get-PSReadlineOption

    # Token Foreground                                # base16 colors
    $options.CommandForegroundColor   = "DarkBlue"    # base0D
    $options.CommentForegroundColor   = "Yellow"      # base03
    $options.KeywordForegroundColor   = "DarkMagenta" # base0E
    $options.MemberForegroundColor    = "DarkBlue"    # base0D
    $options.NumberForegroundColor    = "Red"         # base09
    $options.OperatorForegroundColor  = "DarkCyan"    # base0C
    $options.ParameterForegroundColor = "Red"         # base09
    $options.StringForegroundColor    = "DarkGreen"   # base0B
    $options.TypeForegroundColor      = "DarkYellow"  # base0A
    $options.VariableForegroundColor  = "DarkRed"     # base08
}
