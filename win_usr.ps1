#usage .\win_usr.ps1 user

param (
	[Parameter()]
	(String)$keep
)

#disable and remove from admin group all users except $keep
#add to admin group and change password for $keep
