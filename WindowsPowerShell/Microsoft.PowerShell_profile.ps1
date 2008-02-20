
new-psdrive -name Home -psprovider FileSystem -root C:\home\eric

new-item -path alias:gvim -value "C:\Program Files\Vim\vim71\gvim.exe"

function pro {
	gvim $profile
}

function updatepro {
	Copy-Item Home:Microsoft.PowerShell_profile.ps1 $profile -force
}
function updaterepo {
	Copy-Item $profile Home:Microsoft.PowerShell_profile.ps1
}

