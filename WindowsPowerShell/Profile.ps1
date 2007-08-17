# ---------------------------------------------------------------------------
# Author: Keith Hill
# Desc:   Simple global profile to get you going with PowerShell.
# Date:   Nov 18, 2006
# Site:   http://www.codeplex.com/PowerShellCX
# Usage:  Copy this file to your WindowsPowerShell directory e.g.:
#
#  Copy-Item "$env:PscxHome\Scripts\Profile.ps1" (Split-Path $Profile -Parent)
#
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Create a $UserProfile variable to point to this global profile script
# ---------------------------------------------------------------------------
$ProfileDir = split-path $MyInvocation.MyCommand.Path -Parent
$UserProfile = "$ProfileDir\Profile.ps1"

# ---------------------------------------------------------------------------
# Shell configuration variables
# ---------------------------------------------------------------------------
$MaximumHistoryCount = 512
$FormatEnumerationLimit = 100

# ---------------------------------------------------------------------------
# PowerShell Community Extensions preference variables. Comment/uncomment
# to suit your preferences.
# ---------------------------------------------------------------------------
$PscxTextEditorPreference = "gvim"
$PscxCdWindowTitlePrefixPreference = "PoSh "
# $PscxCdWindowTitleUpdatePreference = $false
# $PscxSmtpHostPreference="smtp.some.domain.com"
# $PscxSmtpPortPreference=587
# $PscxSmtpFromPreference="john_doe@some.domain.com"

# ---------------------------------------------------------------------------
# Load the PSCX Snapin
# ---------------------------------------------------------------------------
Add-PSSnapin Pscx

# ---------------------------------------------------------------------------
# PowerShell Community Extensions utility functions and filters.
# Comment out any script that you don't want or need.
# ---------------------------------------------------------------------------
. "$env:PscxHome\Scripts\Debug.ps1"
. "$env:PscxHome\Scripts\Prompt.ps1"
. "$env:PscxHome\Scripts\PscxCmdletAliases.ps1"
. "$env:PscxHome\Scripts\GenericAliases.ps1"
. "$env:PscxHome\Scripts\GenericFilters.ps1"
. "$env:PscxHome\Scripts\GenericFunctions.ps1"
. "$env:PscxHome\Scripts\Cd.ps1"
. "$env:PscxHome\Scripts\Dir.ps1"
. "$env:PscxHome\Scripts\History.ps1"
. "$env:PscxHome\Scripts\TabExpansion.ps1"

# If Visual Studio 2005 is installed, set up environment to use compilers
if ($env:VS80COMNTOOLS -ne $null) {
	. "$env:PscxHome\Scripts\vs80vars.ps1"
}

# This will create a record or transcript of the entire PoSh session
. "$env:PscxHome\Scripts\TranscribeSession.ps1"
