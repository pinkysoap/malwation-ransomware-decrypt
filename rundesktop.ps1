$desktop = [Environment]::GetFolderPath("Desktop")
$testDir = Join-Path $desktop "test"

if (-Not (Test-Path $testDir)) {
    Write-Host "Directory '$testDir' does not exist."
    exit 1
}

$encryptedFiles = Get-ChildItem -Path $testDir -Filter *.encrypted -File

if ($encryptedFiles.Count -eq 0) {
    Write-Host "No .encrypted files found in '$testDir'."
    exit 0
}

foreach ($file in $encryptedFiles) {
    $fullPath = $file.FullName
    Write-Host "Decrypting: $fullPath"
    & ".\malware-decrypt2.exe" "`"$fullPath`""
}
