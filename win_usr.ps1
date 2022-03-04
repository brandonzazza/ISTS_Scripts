#usage .\win_usr.ps1 <scoring user>

param (
	[Parameter()]
	(String)$keep
)

#disable and remove from admin group all users except $keep
#add to admin group and change password for $keep

$users = (Get-WmiObject -Class Win32_UserAccount | Select-Object -ExpandProperty name)
foreach ($u in $users) {
	if ($u -eq $keep) {
		net user $u /active:yes > $null 2>&1
		net localgroup administrators $u /add > $null 2>&1
		echo "change $u's password:"
		net user $u $(Read-Host -AsSecureString) > $null 2>&1
		echo "scoring user $u set up"
	} else {
		net user $u /active:no > $null 2>&1
		net localgroup administrators $u /delete > $null 2>&1
		echo "$u disabled"
	}
}

#turn on all default firewalls
netsh AdvFirewall set AllProfiles state on > $null 2>&1
echo "firewalls enabled"

#change scoring user password in scorestack
#log out and then back in as scoring user
