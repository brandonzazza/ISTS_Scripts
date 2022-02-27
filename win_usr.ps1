# disable all users except the one currently logged in
# prompt to change password of current user
# if there is an admin user (ex. whiteteam), manually reenable after running
$users = (get-localuser | select-object -expandproperty name)
foreach ($u in $users) {
	if ($u -eq $env:username) {
		echo "change $u password"
		set-localuser $u -password $(read-host -assecurestring)
	} else {
		echo "disable $u"
		disable-localuser $u
	}
}
