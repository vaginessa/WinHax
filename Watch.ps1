# Script ...

    ### Service registrieren
    $watcher = New-Object System.IO.FileSystemWatcher
    ## Zu überwachender Pfad
    $watcher.Path = "H:\Mail Enable\Postoffices\zarat-solutions.ml\MAILROOT\support\Inbox"
    ## Dateifilter
    $watcher.Filter = "*.MAI"
    ## Unterverzeichnisse mit einbeziehen?
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true

    ### Action nachdem Event gestartet wurde?
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date) -> $env:username $changeType $path"
                Add-content "C:\users\root\Desktop\log.txt" -value $logline
              }    

    ## Welche Events werden aufgezeichnet? 
    Register-ObjectEvent $watcher "Created" -Action $action
    ##Register-ObjectEvent $watcher "Changed" -Action $action
    Register-ObjectEvent $watcher "Deleted" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action

    ## Das ganze alle 5 Sekunden
    while ($true) {sleep 5}