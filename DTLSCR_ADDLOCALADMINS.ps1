function Add-DomainUserToLocalGroup{

<#
.DESCRIPTION
	Add a domain user to a computer local group
.PARAMETER  Domain
	The domain which the user belongs to
	
.PARAMETER  User
	Name of the domain user
.PARAMETER  Group
	Local GroupName
	
.PARAMETER  Computer
	Computer name to process this command
    
.PARAMETER  Credentials
	Computer name to process this command
    
.EXAMPLE
	Add-DomainUserToLocalGroup -Domain contoso.com -User User1 -Group Administrators -

Computer Server1.contoso.com
#>
	
	<#param(
		[Parameter(Mandatory=$true)]
		[String]
		$Domain,
		
		[Parameter(Mandatory=$true)]
		[String]
		$ADGroup,
		
		[Parameter(Mandatory=$true)]
		[String]
		$Group,
		
		[Parameter(Mandatory=$true)]
		[String]
		$Computer,
       
		[Parameter(Mandatory=$false)]
		$Credentials    
        
	)
    #>
	$Domain = (Get-WmiObject Win32_ComputerSystem).Domain
    $computer = hostname
    $ADGroup = "LABS\Devtstlabs-Powerusers"
    $LocalGroup = [ADSI]"WinNT://$Computer/$Group,group"    	
    $DomainGroup = [ADSI]"WinNT://$Domain/$ADGroup,group"        	
    Write-Host "Adding domain group: $ADGroup from: $Domain to local group: $Group on computer: 

$Computer"        	
    $LocalGroup.Add($DomainGroup.Path)
}


$computername = (Get-CIMInstance CIM_ComputerSystem).Name
$domainname = (Get-WmiObject Win32_ComputerSystem).Domain

Add-DomainUserToLocalGroup -Domain $domainname -ADGroup $ADGroup -Group Administrators -Computer $computername
