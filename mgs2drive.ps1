$source='C:\AirbusHelicopters\MGS\server\data_storage\data_collection\Flights'
$destinationKAE='C:\Users\User_Ground_Tools\Dropbox\21049_LV-KAE_HOMP\Commercial'
$destinationKAF='C:\Users\User_Ground_Tools\Dropbox\21061_LV-KAF_HOMP\Commercial'

$vuelosKAE_hoy=Get-ChildItem -Path $source'\*\145T3_21049\?????' -Name | Sort-Object -Unique
$vuelosKAF_hoy=Get-ChildItem -Path $source'\*\145T3_21061\?????' -Name | Sort-Object -Unique

$ultimo_vuelo_copiado_KAE=Get-Content C:\kostas\vuelosKAE_historico.txt
$ultimo_vuelo_copiado_KAF=Get-Content C:\kostas\vuelosKAF_historico.txt
Write-Host ''


Write-Host "Buscando vuelos LV-KAE en MGS..."
Start-Sleep -Seconds 1

$tocopyKAE=Compare-Object $ultimo_vuelo_copiado_KAE $vuelosKAE_hoy -PassThru
$repKAE=0
foreach ($flight in $tocopyKAE)
{
    if($flight -ne ''){
        Write-Host "copy FDCR.zip to flight folder number: "$flight
        Copy-Item -Path $source'\*\145T3_21049\'$flight -Destination $destinationKAE -ErrorAction SilentlyContinue
        Copy-Item -Path $source'\*\145T3_21049\'$flight'\FDCR.zip' -Destination $destinationKAE'\'$flight -ErrorAction SilentlyContinue
        $repKAE++
        }

}

$vuelosKAE_hoy > C:\kostas\vuelosKAE_historico.txt

Write-Host "Buscando vuelos LV-KAF en MGS..."
Start-Sleep -Seconds 1

$tocopyKAF=Compare-Object $ultimo_vuelo_copiado_KAF $vuelosKAF_hoy -PassThru
$repKAF=0
foreach ($flight in $tocopyKAF)
{
    if($flight -ne ''){
        Write-Host "copy FDCR.zip to flight folder number: "$flight
        Copy-Item -Path $source'\*\145T3_21061\'$flight -Destination $destinationKAF -ErrorAction SilentlyContinue
        Copy-Item -Path $source'\*\145T3_21061\'$flight'\FDCR.zip' -Destination $destinationKAF'\'$flight -ErrorAction SilentlyContinue
        $repKAF++
        }

}

$vuelosKAF_hoy > C:\kostas\vuelosKAF_historico.txt
Write-Host ''
Write-Host 'Se han copiado vuelo(s) '$repKAE.ToString()' del LV-KAE'
Write-Host 'Se han copiado vuelo(s) '$repKAF.ToString()' del LV-KAF'
Write-Host ''
Read-Host "Presiona ENTER para terminar"