Param(
	[parameter(Mandatory=$true)]            
    [ValidateNotNullOrEmpty()]             
    [String] $Configuration,
    [String] $CurrentPath = "..", 
	[bool]$Prompt=$false,
	[bool]$ConsoleMode=$false,
	[bool]$DoNotStop=$false
)

$CURRENTDIR=pwd
trap {write-host "error"+ $error[0].ToString() + $error[0].InvocationInfo.PositionMessage  -Foregroundcolor Red; cd "$CURRENTDIR"; read-host 'There has been an error'; break}

if ($CURRENTDIR -eq "C:\Windows\system32")
{
    cd c:\svc\shared\trunk\scripts
}

    write-host "** copying msbuild files to $Global_MsbuildPath"
    Copy-Item "$CurrentPath\K2Field.Utilities.ServiceObjectBuilder\MSBuild Folder\*" $Global_MsbuildPath -recurse -force
    Copy-Item "$CurrentPath\K2Field.Utilities.Build\MSBuild Folder\*" $Global_MsbuildPath -recurse -force
    write-host "** finished copying msbuild files"
	$ServiceBrokerSubDirectory="ServiceBroker\CustomServiceBrokers"
	
	Restart-K2Server -WaitUntilRestart $true -Prompt $Prompt -ConsoleMode $ConsoleMode
	
	##Copy-Files -SourcePath "$CurrentPath\K2Field.Utilities.Build\bin\$Configuration" -DestinationDirectory "$Global_K2BlackPearlDir$ServiceBrokerSubDirectory"
	##Copy-Files -SourcePath "$CurrentPath\TLT.K2Shared.ServiceBrokers\Services.WorklistService\bin\$Configuration\*" -DestinationDirectory "$Global_K2BlackPearlDir$ServiceBrokerSubDirectory" -deleteFirst $false
    ##Copy-Files -SourcePath "$CurrentPath\TLT.K2Shared.ServiceBrokers\SharePointGroups\MOSSServiceObject\bin\$Configuration" -DestinationDirectory "$Global_K2BlackPearlDir$ServiceBrokerSubDirectory"
    

$message= "======Finished Copying all files to the correct location======"
If($DoNotStop){Write-Host $message} else {Read-Host $message}
