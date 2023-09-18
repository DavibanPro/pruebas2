@echo off
setlocal

rem Definir la ruta de origen y destino
set "carpeta_origen=C:\prueba\operacion\proceso_diario"
set "carpeta_destino_base=C:\prueba\recibido"

rem Obtener la fecha actual en el formato YYYYMMDD
for /f %%A in ('powershell -command "Get-Date -format 'yyyyMMdd'"') do set "fecha_actual=%%A"

rem Crear la carpeta de destino con la fecha actual
set "carpeta_destino=%carpeta_destino_base%\%fecha_actual%"
mkdir "%carpeta_destino%"

rem Comprimir la carpeta de origen en un archivo ZIP
powershell -command "Compress-Archive -Path '%carpeta_origen%' -DestinationPath '%carpeta_destino%\proceso_diario.zip'"

rem Verificar si la compresión fue exitosa antes de continuar
if %errorlevel% equ 0 (
    echo Carpeta comprimida y movida correctamente.
) else (
    echo Error al comprimir la carpeta.
    goto :fin
)

rem Copiar la carpeta original a la carpeta de destino
xcopy /s /e /i /h "%carpeta_origen%" "%carpeta_destino%\proceso_diario"

rem Verificar si la copia fue exitosa
if %errorlevel% equ 0 (
    echo Carpeta copiada correctamente.
) else (
    echo Error al copiar la carpeta.
)

:fin
endlocal
