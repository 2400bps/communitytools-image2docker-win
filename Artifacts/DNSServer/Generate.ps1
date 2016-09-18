<#
.SYNOPSIS
Generates Dockerfile contents for DNS Server component 

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

if ($Artifact.Status -eq 'Enabled') {
    $Result = 'RUN powershell.exe -ExecutionPolicy Bypass -Command Enable-WindowsOptionalFeature -Online -FeatureName DNS-Server-Full-Role'
}

Write-Output -InputObject $Result