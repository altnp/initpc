Write-header "Setting up Network..."

if (Confirm-Action "Set custom DNS Provider(s)?") {
    $adapters = Get-NetAdapter | Select-Object Name, Status

    do {
        for ($i = 0; $i -lt $adapters.Count; $i++) {
            Write-Host ("{0}. {1} ({2})" -f ($i + 1), $adapters[$i].Name, $adapters[$i].Status)
        }

        $selection = Read-Host "`nSelect an adapter by number (Press Enter to Proceed)"

        if (-not $selection) {
            Write-Host "Exiting..." -ForegroundColor Green
            break
        }

        if (-not [int]::TryParse($selection, [ref]$null)) {
            Write-Host "Please enter a valid number`n" -ForegroundColor Yellow
            continue
        }

        if ($selection -lt 1 -or $selection -gt $adapters.Count) {
            Write-Host "Invalid selection`n" -ForegroundColor Yellow
            continue
        }

        $selectedAdapter = $adapters[$selection - 1].Name
        $dnsAddress = Read-Host "Enter the DNS address (Press enter for default 1.1.1.1)"
        if (-not $dnsAddress) { $dnsAddress = "1.1.1.1" }

        Set-DnsClientServerAddress -InterfaceAlias $selectedAdapter -ServerAddresses $dnsAddress
        Write-Host "`nSuccess! DNS set for $selectedAdapter.`n" -ForegroundColor Green

    } while (Confirm-Action "Set custom DNS Provider(s)?")
}
