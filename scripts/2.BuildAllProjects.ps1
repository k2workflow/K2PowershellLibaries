Param(

    [parameter(Mandatory=$false)]   
    [String] $Environment, 
	
    [string]$ManifestFile="$Global_ManifestFile",
   
    [parameter(Mandatory=$false)]               
    [ValidateNotNullOrEmpty()]    
    [String] $SourceCodePath = "..\", 
   
    [parameter(Mandatory=$false)]            
    [ValidateNotNullOrEmpty()]             
    [String] $K2DeploymentUtilitiesSolutionFile = "K2Field.Utilities.Deploy.sln",
   
    [parameter(Mandatory=$false)]            
    [ValidateNotNullOrEmpty()]             
    [String] $ServiceBrokerSolutionFile = "TLT.K2Shared.ServiceBrokers.sln",
    
	[parameter(Mandatory=$true)]            
    [ValidateNotNullOrEmpty()]             
    [String] $Configuration,
    
    [parameter(Mandatory=$false)]            
    [ValidateNotNullOrEmpty()]            
    [Switch] $CleanFirst,
	
	[ValidateNotNullOrEmpty()]                  
        [string] $BuildLogOutputPath = "..\"  
)

$CURRENTDIR=pwd
###For testing in Poswershell ISE only
if ($CURRENTDIR -eq "C:\Windows\system32")
{
    cd c:\svc\shared\trunk\scripts
}

trap {write-host "error"+ $error[0].ToString() + $error[0].InvocationInfo.PositionMessage  -Foregroundcolor Red; cd "$CURRENTDIR"; read-host 'There has been an error'; break}

###$ErrorActionPreference ="Stop"

write-debug "Publish-VisualStudioSolution -SourceCodePath $SourceCodePath -SolutionFile $K2DeploymentUtilitiesSolutionFile -CleanFirst $CleanFirst -BuildLogFile $K2DeploymentUtilitiesSolutionFile.log.txt -BuildLogOutputPath $BuildLogOutputPath -Configuration $Configuration"
Publish-VisualStudioSolution -SourceCodePath $SourceCodePath -SolutionFile $K2DeploymentUtilitiesSolutionFile -CleanFirst $CleanFirst -BuildLogFile "$K2DeploymentUtilitiesSolutionFile.log.txt" -BuildLogOutputPath $BuildLogOutputPath -Configuration $Configuration -debug
Publish-VisualStudioSolution -SourceCodePath $SourceCodePath -SolutionFile $ServiceBrokerSolutionFile -CleanFirst $CleanFirst -BuildLogFile "SourceCode.SmartObjects.Services.log.txt" -BuildLogOutputPath $BuildLogOutputPath -Configuration $Configuration -debug

#TODO: Report errors and stop
$message= "======Finished Building All Deployment Projects======"
If($DoNotStop){Write-Host $message} else {Read-Host $message}