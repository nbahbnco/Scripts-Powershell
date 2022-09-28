$previousStoppedAutomaticServices = Get-Content .\StoppedAutomaticServices.json | ConvertFrom-Json

$stoppedAutomaticServices = Get-Service | Select-Object -Property Name, Status, StartType | Where-Object {
    $_.Status -eq "Stopped" -and $_.StartType -eq "Automatic" 
}

$stoppedAutomaticServices | ForEach-Object { 
    $_ | Add-Member -MemberType NoteProperty -Name 'RestartAttemps' -Value 1
}

if ($null -eq $previousStoppedAutomaticServices ) {
    $StoppedAutomaticServices | ConvertTo-Json | Out-File .\StoppedAutomaticServices.json # Inicializamos el fichero si no existe
    Write-Output "Intializing File"
}
else {
    $collectStoppedAutomaticServices = @{}
    $collectStoppedAutomaticServices = Compare-Object -ReferenceObject $previousStoppedAutomaticServices -IncludeEqual -Property Name -PassThru  -DifferenceObject  $stoppedAutomaticServices  

    $collectStoppedAutomaticServices | ForEach-Object {
        $_.RestartAttemps += 1
    }
    
    $collectStoppedAutomaticServices | ConvertTo-Json | Out-File .\StoppedAutomaticServices.json
}

$stoppedAutomaticServices | ForEach-Object {
    if ($_.RestartAttemps -le 10 ) {
        Start-Service -Name $_.Name
    }
}

