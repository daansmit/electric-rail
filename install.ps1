$modName = "electric-rail"
$version = "0.0.1"

$modFolder = "$env:USERPROFILE\AppData\Roaming\Factorio\mods\$modname" + "_" + "$version"
$savesFolder = "$env:USERPROFILE\AppData\Roaming\Factorio\saves"
$gameLocation = 'C:\Program Files (x86)\Steam\steamapps\common\Factorio\bin\x64\factorio.exe'

# First remove the exting version
Remove-Item $modFolder -Recurse -ErrorAction SilentlyContinue

# Copy everthing in the src directory to Factorio's mods folder
Copy-Item -Path ./src -Destination $modFolder -Recurse -Force

Write-Host "Mod data succesfully copied"

# Find the most recent autosave and open game with that save
$lastSave = Get-ChildItem $savesFolder | Sort {$_.LastWriteTime} | select -last 1
Write-Host "Starting factorio with savedgame: " $lastSave.Name


& $gameLocation '--loadgame $lastSave'
