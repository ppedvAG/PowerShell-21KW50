Configuration dynamicServerConfig
{
    Node $AllNodes.Nodename
    {
        foreach($Feature in $Node.WindowsFeatures)
        {
            WindowsFeature $Feature.Name
            {
                Name = $Feature.Name
                Ensure = $Feature.Ensure
            }
        }
    }
}

dynamicServerConfig -OutputPath C:\KursFiles\FortgeschritteneTechniken\DSC\dynamic -ConfigurationData C:\KursFiles\FortgeschritteneTechniken\DSC\dynamic\dsc-web.psd1

#Start-DscConfiguration -Wait -Verbose -Path C:\KursFiles\FortgeschritteneTechniken\DSC\dynamisch