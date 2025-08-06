Write-Header "Disabling sleep during install..."
$activeSchemeGuid = (powercfg /GETACTIVESCHEME).Split()[3]
powercfg /SETACVALUEINDEX $activeSchemeGuid SUB_VIDEO VIDEOIDLE 0
powercfg /SETACVALUEINDEX $activeSchemeGuid SUB_SLEEP STANDBYIDLE 0
powercfg /SETACTIVE $activeSchemeGuid
