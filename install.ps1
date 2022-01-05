function Log([string]$message) {
    Write-Host $message
}

function Test-Symbolic-Link([string]$path) {
    # Check if file exists
    if (Test-Path $path -PathType Leaf) {
        # Check if file is a symbolic link
        $file = Get-Item $path -Force -ea SilentlyContinue
         
        if (![bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            Log("The ${path} file already exists and is not a symbolic link. Skipping.")
        }

        return $false
    } else {
        return $true
    }
}

$appdataDirectory = "~\AppData\Local\Programs\dotfiles"

# Create dotfiles directory in appdata if it doesn't exist
if (!(Test-Path $appdataDirectory)) {
    New-Item $appdataDirectory -type directory -force -ea SilentlyContinue
}


$profilePath = Join-Path -Path (Split-Path -Path $PROFILE) -ChildPath "dotfiles-profile.ps1"
if (Test-Symbolic-Link $profilePath) {
    Log("Creating symbolic link for profile: ${profilePath}")

    New-Item -ItemType SymbolicLink -Path $profilePath -Value .\windows-specific\powershell-profile.ps1 -Force

    Log("Symbolic link created.")
    Log("To use the profile, add: Import-Module .\dotfiles-profile.ps1 to your `$PROFILE")
}

$themePath = Join-Path -Path $appdataDirectory -ChildPath "poshthemes"
if (Test-Symbolic-Link $themePath) {
    Log("Creating symbolic link for themes: ${themePath}")

    New-Item -ItemType SymbolicLink -Path $themePath -Value .\poshthemes -Force

    Log("Symbolic link created.")
}
