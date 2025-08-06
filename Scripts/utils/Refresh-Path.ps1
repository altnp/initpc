function Refresh-Path {
    Write-Host "Refreshing Path.."
    $env:NVM_HOME = [System.Environment]::GetEnvironmentVariable('NVM_HOME', 'Machine')
    $env:NVM_SYMLINK = [System.Environment]::GetEnvironmentVariable('NVM_SYMLINK', 'Machine')
    $systemPath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
    $userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')

    $env:Path = $systemPath + ';' + $userPath
}
