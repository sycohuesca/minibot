# Ejercicio 1 por Armando Jiménez Lucea
Param (
[Switch]
 $Save
    )



# Creamos un objeto que guardara los datos
$object = New-Object –TypeName PSObject


#Version sistema operativo
echo ""
echo "--------------Version del Sistema operatvio------------------------"
$OS=[System.Environment]::OSVersion |Select-Object -Property VersionString
$object | Add-Member –MemberType NoteProperty –Name OS –Value $OS
echo $object.OS.VersionString

# Nombre del equipo
echo ""
echo "--------------Nombre del equipo------------------------------------"
$SystemInfo=whoami
$object | Add-Member –MemberType NoteProperty –Name SystemInfo –Value $SystemInfo
echo $object.SystemInfo

# Parches de seguridad
echo ""
echo "--------------Parches de seguridad instalados----------------------"
$Revisiones= Get-WmiObject -query 'select * from win32_quickfixengineering' | Where-Object {$_.description -eq "Security Update"} | Format-List
$object | Add-Member –MemberType NoteProperty –Name Revisiones –Value $Revisiones
echo $object.Revisiones

# listado de usuarios grupo administradores
echo ""
echo "--------------Usuarios del grupo Administradores-------------------"
$UsersAdmin=Get-CimInstance -ClassName Win32_Group | Where-Object {$_.Name -eq "Administradores"} | Get-CimAssociatedInstance -Association Win32_GroupUser |Select-Object -Property Name, SID
$object | Add-Member –MemberType NoteProperty –Name UsersAdmin –Value $UsersAdmin 
echo $object.UsersAdmin

# Lista de procesos en ejecucion
echo ""
echo "--------------Lista de  procesos en ejecucion----------------------"
$Procesos=Get-Process | Select-Object -Property ProcessName | Format-Wide -AutoSize
$object | Add-Member –MemberType NoteProperty –Name Procesos –Value $Procesos
echo $object.Procesos

if ($save){
$usuario=$env:UserName
$ruta="c:\users\$usuario\Desktop\info.txt"
$object.OS | Out-File -filePath $ruta
$object.SystemInfo | Out-File -filePath $ruta -Append
$object.UsersAdmin | Out-File -filePath $ruta -Append
$object.Revisiones | Out-File -filePath $ruta -Append
$object.Procesos | Out-File -filePath $ruta -Append
echo "Archivo guardado en $ruta"
}
