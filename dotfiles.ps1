# Set the root path of your dotfiles repository.
$dotfilesRoot = "$HOME/.dotfiles"

# Set the path to the user's home directory.
$homePath = $env:USERPROFILE

# Set the path to the user's .config directory.
$homeConfigPath = Join-Path -Path $homePath -ChildPath '.config'

# Add any folder names to this array that you want to skip.
$foldersToSkip = @("assets")

# Get all of the top-level folders (components) in your dotfiles repository.
$components = Get-ChildItem -Path $dotfilesRoot -Directory

# --- Section 1: Handle .config dotfiles ---
Write-Host "--- Handling .config dotfiles ---" -ForegroundColor Green
foreach ($component in $components) {
    if ($foldersToSkip -contains $component.Name) {
        Write-Host "Skipping $($component.Name) as requested." -ForegroundColor Yellow
        continue
    }

    $sourcePath = Join-Path -Path $component.FullName -ChildPath ".config\$($component.Name)"
    $destinationPath = Join-Path -Path $homeConfigPath -ChildPath $component.Name
    
    if (Test-Path -Path $sourcePath) {
        Write-Host "Linking .config files for: $($component.Name)" -ForegroundColor Cyan
        
        if (-not (Test-Path -Path $homeConfigPath -PathType Container)) {
            New-Item -Path $homeConfigPath -ItemType Directory | Out-Null
        }
        
        if (Test-Path -Path $destinationPath) {
            Write-Host "  - Removing existing item at destination." -ForegroundColor Yellow
            Remove-Item -Path $destinationPath -Recurse -Force
        }

        New-Item -ItemType SymbolicLink -Path $destinationPath -Target $sourcePath -Force | Out-Null
    }
}

# --- Section 2: Handle home directory dotfiles ---
Write-Host "`n--- Handling home directory dotfiles ---" -ForegroundColor Green
foreach ($component in $components) {
    # --- NEW ---
    if ($foldersToSkip -contains $component.Name) {
        Write-Host "Skipping $($component.Name) as requested." -ForegroundColor Yellow
        continue
    }
    # --- END NEW ---

    $nonConfigItems = Get-ChildItem -Path $component.FullName -Exclude '.config' -Force
    
    foreach ($item in $nonConfigItems) {
        $sourcePath = $item.FullName
        $destinationPath = Join-Path -Path $homePath -ChildPath $item.Name

        Write-Host "Linking file: $($item.Name) from component $($component.Name)" -ForegroundColor Cyan
        
        if (Test-Path -Path $destinationPath) {
            Write-Host "  - Removing existing item at destination." -ForegroundColor Yellow
            Remove-Item -Path $destinationPath -Recurse -Force
        }
        
        New-Item -ItemType SymbolicLink -Path $destinationPath -Target $sourcePath -Force | Out-Null
    }
}

Write-Host "`nAll operations complete." -ForegroundColor Green
