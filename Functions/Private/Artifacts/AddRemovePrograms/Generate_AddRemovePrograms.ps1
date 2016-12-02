﻿function Generate_AddRemovePrograms {
<#
.SYNOPSIS
Generate Dockerfile contents for Add/Remove Programs entries 

.PARAMETER ManifestPath
The filesystem path where the JSON manifests are stored.
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $ManifestPath
)

$ArtifactName = Split-Path -Path $PSScriptRoot -Leaf

Write-Verbose -Message ('Generating Dockerfile result for {0} component' -f (Split-Path -Path $PSScriptRoot -Leaf))
$Manifest = '{0}\{1}.json' -f $ManifestPath, $ArtifactName

$Artifact = Get-Content -Path $Manifest -Raw | ConvertFrom-Json

$Result = ''
foreach ($Item in $Artifact) {
    $Result += '# {0} {1}' -f $Item, "`r`n"
}

Write-Output -InputObject $Result

}

