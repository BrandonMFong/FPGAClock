[String]$Vivado_init_Path = (Get-ChildItem $PSScriptRoot\..\resources\vivado-boards\utility\Vivado_init.tcl).FullName; # Get file path
Push-Location $env:APPDATA;
    Set-Location .\Xilinx\Vivado\;
    [String]$Vivado_dest_Path = (Get-Location).Path; # Get destination path
Pop-Location;

[String]$FileContent = Get-Content $Vivado_init_Path;
Push-Location $PSScriptRoot\..\;
    $FileContent = $FileContent.Replace('@Replace',(Get-Location).Path); # replace with this repos file path
    $FileContent = $FileContent.Replace("\","/"); # follow the forward slash directory syntax
    Set-Content -Path $Vivado_init_Path -Value $FileContent; # Save the content into the file
    Copy-Item $Vivado_init_Path $Vivado_dest_Path -Force -Verbose; # Copy the file to the destination 
Pop-Location;
