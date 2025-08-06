Write-Header "Re-enabling Sleep..."
$activeSchemeGuid = (powercfg /GETACTIVESCHEME).Split()[3]
powercfg /SETACVALUEINDEX $activeSchemeGuid SUB_VIDEO VIDEOIDLE 600
powercfg /SETACVALUEINDEX $activeSchemeGuid SUB_SLEEP STANDBYIDLE 600
powercfg /SETACTIVE $activeSchemeGuid
