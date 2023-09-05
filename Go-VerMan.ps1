# Command line args
$command = $args[0] # Should be one of "use", "install", "list"

# USERPROFILE directory
$userDir = $env:USERPROFILE
$installDir = "$userDir\.go\sdks"


switch($command) {
    "list" {
        $folders = Get-ChildItem -Path $installDir -Directory
        $index = 0
        Write-Host "Installed Go versions are ... "
        $folders | ForEach-Object { ' {0})   {1}' -f ++$index, $_.Name }
    }

    "use" {
        $target = $args[1]
        $target = "$installDir\$target"
        # $target = Get-ChildItem -Path $installDir -Directory | Where-Object { $_.Name -eq $use }
        Write-Host "Selected $target"

        $current = $Env:GOROOT

        [Environment]::SetEnvironmentVariable("GOROOT", $target, "User")
        [Environment]::SetEnvironmentVariable("GOROOT", $target, "Process")

        # If there was a previous version, update current system path
        if ($null -ne $current) {
            [Environment]::SetEnvironmentVariable("PATH", ($Env:PATH -replace [regex]::Escape("$current"), "$Env:GOROOT"), "Process")
        }
    }

    "install" {
        $architecture = "windows-amd64"
        $version = $args[1]
        $url = "https://dl.google.com/go/$version.$architecture.zip"

        # Configure no progress output
        $ProgressPreference = 'SilentlyContinue'
        
        # Download the zip
        Write-Host "Downloading $version ..."
        Invoke-WebRequest $url -OutFile "$installDir\$version.$architecture.zip"

        # Extract the zip
        Write-Host "Installing $version ..."
        $extractJob = Start-Process -FilePath "C:\Program Files\7-Zip\7z.exe" -ArgumentList "x $installDir\$version.$architecture.zip -o$installDir\$version" -PassThru -NoNewWindow
        $extractJob.WaitForExit()

        # Finally move inner `go` out
        Move-Item -Path "$installDir\$version\go\*" -Destination "$installDir\$version"
        Remove-Item "$installDir\$version\go\"

        Write-Host "Successfully installed $version"
    }

    "uninstall" {
        $version = $args[1]
        # Check installed version exists
        if (-not (Test-Path -Path "$installDir\$version" -PathType Container)) {
            Write-Host "$version is not installed."
            Exit 
        }

        Write-Host "Removing $version ..."
        Remove-Item "$installDir\$version" -Recurse -Force
        Write-Host "Successfully uninstalled $version"
    }

    default {
        Write-Host "invalid or unspecified command line argument. Supported commands are ('list', 'use', 'install')"
    }
}