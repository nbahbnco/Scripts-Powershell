Get-Childitem -Path C:\ -Recurse -ErrorAction SilentlyContinue -Include *zabbix_sender.exe* -File | ForEach-Object {$_.Fullname | Out-File -Filepath ./ZabbixSenderPath}
# Crear campo para eventos.
New-EventLog -LogName Application -Source "Zabbix Sender"
