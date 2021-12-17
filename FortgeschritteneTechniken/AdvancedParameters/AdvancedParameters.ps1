function Test-AdvancedParameters{
[cmdletBinding(PositionalBinding=$false,DefaultparameterSetName="Set1")]
param(

    [Parameter(ParameterSetName="Set1",
               Mandatory=$true, 
               Position=0,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true,
               HelpMessage="Geben sie eine Farbe an")]
    $param1,

    [Parameter(ParameterSetName="Set1",Mandatory=$false)]
    [Parameter(ParameterSetName="Set2",Mandatory=$true)]
    $param2,

    
    [Parameter(Mandatory=$true)]
    $param3
)
}