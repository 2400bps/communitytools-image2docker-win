﻿function Generate_AllWindowsFeatures {
<#
.SYNOPSIS
Generates Dockerfile contents for DHCP Server component 

.PARAMETER ManifestPath
The filesystem path where the JSON manifests are stored.
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $ManifestPath
)

$ArtifactName = Split-Path -Path $PSScriptRoot -Leaf

Write-Verbose -Message ('Generating result for {0} component' -f $ArtifactName)
$Manifest = '{0}\{1}.json' -f $ManifestPath, $ArtifactName

$Artifact = Get-Content -Path $Manifest -Raw | ConvertFrom-Json

$Result =''

$FeatureNames = $Artifact.FeatureName.replace(';',',')

    $Result += "RUN powershell.exe -ExecutionPolicy Bypass -Command Enable-WindowsOptionalFeature -Online -FeatureName $FeatureNames -All `r`n"


Write-Output -InputObject $Result
}

