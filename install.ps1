Write-Host "���������"

# Vars
$dockerPath = "$(Get-Location)\docker"
$dockerComposePath = "$(Get-Location)\docker\cli-plugins"
$dockerHost = "tcp://127.0.0.1:2375"
$7zPath = "$env:ProgramFiles\7-Zip\7z.exe"

# Is 7zip installed?
if (-not (Test-Path $7zPath)) {
    if (-not (winget install 7zip -s winget)) {
        throw "������ �����? ��� 7z? winget �������?"
    }
}
Set-Alias 7zip $7zPath

# Expand distro
7zip  e ".\ubuntu.zip.001"

# Install wsl
wsl --install
# Import distro
if (wsl --import ubuntu-docker $env:HOME\WSL .\ubuntu) {
    Write-Host "����� ������������"
}

# Set environment
$env:PATH += $dockerPath
Write-Host "�������� PATH $($dockerPath)"

$env:PATH += $dockerComposePath
Write-Host "�������� PATH $($dockerComposePath)"

$env:DOCKER_HOST = $dockerHost
Write-Host "�������� DOCKER_HOST $($env:DOCKER_HOST)"

# Start linux
wsl -d ubuntu-docker