configuration SimpleWebServer
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node ("Member1")
    {
        # Ressourcenanbieter aufrufen
        # Beispiel: WindowsFeature, File
        WindowsFeature WebServerRole
        {
           Ensure = "Present"
           Name   = "Web-Server"
        }

        WindowsFeature WebVerwaltung
        {
           Ensure = "Present"
           Name   = "Web-Mgmt-Tools"
           DependsOn = "[WindowsFeature]WebServerRole"
        }
      
    }
}

#zum erzeugen der MOF Datei
SimpleWebServer -OutputPath "C:\KursFiles\FortgeschritteneTechniken\DSC\Simple"

#zum Anwenden der Konfiguration auf die angegeben Nodes
#Start-DscConfiguration -Wait -Verbose -Path "C:\KursFiles\FortgeschritteneTechniken\DSC\Simple"
