function Confirm-Action {
    param (
        [string]$prompt = "Are you sure you want to proceed?"
    )

    while ($true) {
        $confirmation = Read-Host "$prompt [y/n]"

        if ($confirmation -eq 'y') {
            return $true
        } elseif ($confirmation -eq 'n') {
            return $false
        }
    }
}
