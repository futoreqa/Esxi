# ============================
# Universal ESXi ISO Builder
# ============================

$esxiDepotPath = "C:\ESXI_Custom\original_iso\VMware-ESXi-8.0U3f-24784735-depot.zip"
$driversFolder = "C:\ESXi_Custom\driver"
$outputIsoPath = "C:\ESXi_Custom\output_iso\ESXi-Custom.iso"

$customProfileName = "ESXi-Custom"

Write-Host "Loading PowerCLI..."
Import-Module VMware.PowerCLI

Set-PowerCLIConfiguration `
-InvalidCertificateAction Ignore `
-Confirm:$false | Out-Null

Write-Host "Adding ESXi base depot..."
Add-EsxSoftwareDepot $esxiDepotPath | Out-Null

Write-Host "Scanning driver directory..."

$driverZips = Get-ChildItem $driversFolder -Filter *.zip

foreach ($zip in $driverZips) {

    Write-Host "Adding driver depot:" $zip.Name
    Add-EsxSoftwareDepot $zip.FullName | Out-Null

}

Write-Host "Available ESXi profiles:"
Get-EsxImageProfile | Format-Table Name,Vendor,AcceptanceLevel

$baseProfile = Get-EsxImageProfile |
Where-Object { $_.Name -match "standard" } |
Select-Object -First 1

Write-Host "Using base profile:" $baseProfile.Name

$oldProfile = Get-EsxImageProfile -Name $customProfileName -ErrorAction SilentlyContinue

if ($oldProfile) {

    Write-Host "Removing existing profile..."
    Remove-EsxImageProfile $oldProfile -Confirm:$false

}

Write-Host "Cloning profile..."

$customProfile = New-EsxImageProfile `
-CloneProfile $baseProfile `
-Name $customProfileName `
-Vendor "Custom" `
-AcceptanceLevel CommunitySupported

Write-Host "Adding driver packages..."

$driverPackages = Get-EsxSoftwarePackage | Where-Object {
    $_.Vendor -notlike "VMware*"
}

foreach ($pkg in $driverPackages) {

    try {

        Add-EsxSoftwarePackage `
        -ImageProfile $customProfile `
        -SoftwarePackage $pkg.Name

        Write-Host "Added:" $pkg.Name

    } catch {}

}

Write-Host "Exporting ISO..."

Export-EsxImageProfile `
-ImageProfile $customProfile `
-ExportToISO `
-FilePath $outputIsoPath

Write-Host ""
Write-Host "====================================="
Write-Host "Custom ESXi ISO created"
Write-Host $outputIsoPath
Write-Host "====================================="