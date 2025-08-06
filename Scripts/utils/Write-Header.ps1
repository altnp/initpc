function Write-Header {
    param (
        [Parameter(Position=0,mandatory=$true)]
        [string]$prompt
    )

    Write-Host "`n$prompt`n-------------------`n" -ForegroundColor Green
}
