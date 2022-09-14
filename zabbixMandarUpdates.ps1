$zabbixSenderPath=Get-Content .\ZabbixSenderPath
$argumentList=" -z mosy.nubodata.com -s `"AAAA TEST PORTATIL IVAN`" -k trap.test -o 43"
Start-Process -Filepath $zabbixSenderPath -ArgumentList $argumentList -RedirectStandardError Error.log -RedirectStandardOutput Output.log -Wait
$ErrorLog=Get-Content  .\Error.log
$OutputLog=Get-Content  .\Output.log

if ("$OutputLog" -like "*failed*" -and "$OutputLog" -notlike "*failed: 0*" ) {
    Write-EventLog -LogName "Application" -Source "Zabbix Sender" -EventID 10052 -EntryType Error -Message "$OutputLog" -Category 2
}

elseif ("$ErrorLog") {
    Write-EventLog -LogName "Application" -Source "Zabbix Sender" -EventID 10053 -EntryType Error -Message "$ErrorLog" -Category 3
}
else {
    Write-EventLog -LogName "Application" -Source "Zabbix Sender" -EventID 10050 -EntryType Information -Message "$OutputLog" -Category 1
}

