@ECHO OFF

title Script Para Iniciar WinSCP Y Transferir Archivos

:: Script Para Recibir Los Archivos De Servidor (A), Hacía Servidor (B). 
::
::------ Env�a ------ 
:: "Archivo1*.txt"-
:: "Archivo2*.txt"-
:: "Archivo3*.txt"-
::------------------- - 
::
:: Fecha De Ultima Actualización 10/03/2024

:: Captura de fecha del sistema 

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"

set "AA=%dt:~2,2%"
set "AAAA=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Seg=%dt:~12,2%"

:: set "dia_hora=%AAAA%_%MM%_%DD%_%HH%%Min%%Seg%"

set "dia_hora=%DD%%MM%%AAAA%_%HH%%Min%%Seg%"

set "dia=%AAAA%%MM%%DD%"

echo Fecha: %dia_hora% >>C:\LOG\logwinscp_%dia%.txt

::PosicionEnArchivo1

cd C:\DocumentosDeServidorA\Archivo1

::PrimerForArchivo1

FOR %%f IN ( Archivo1*.txt ) DO (
                       MOVE %%f "TEMP/Archivo1_%%~nf_%dia_hora%.txt"  ) >>C:\LOG\logwinscp_%dia%.txt

::RealizoDeBackupArchivo1

cd C:\DocumentosDeServidorA\Archivo1\TEMP 

FOR %%a IN ( Archivo1*.txt ) DO (
                   copy %%a "C:\DocumentosDeServidorA\Archivo1\Backup" ) >>C:\LOG\logwinscp_%dia%.txt

::PosicionEnArchivo2

cd C:\DocumentosDeServidorA\Archivo2

::PrimerForArchivo2

FOR %%f IN ( Archivo2*.txt ) DO (
                       MOVE %%f "TEMP/Archivo2_%%~nf_%dia_hora%.txt" ) >>C:\LOG\logwinscp_%dia%.txt

::RealizoDeBackupArchivo2
					   
cd C:\DocumentosDeServidorA\Archivo2\TEMP

FOR %%a IN ( Archivo2*.txt ) DO (
                   copy %%a "C:\DocumentosDeServidorA\Archivo2\Backup" ) >>C:\LOG\logwinscp_%dia%.txt
				   
::PosicionEnArchivo3

cd C:\DocumentosDeServidorA\Archivo3

::PrimerForArchivo3

FOR %%f IN ( Archivo3*.txt ) DO (
                       MOVE %%f "TEMP/Archivo3_%%~nf_%dia_hora%.txt") >>C:\LOG\logwinscp_%dia%.txt

::RealizoDeBackupArchivo3

cd C:\DocumentosDeServidorA\Archivo3\TEMP

FOR %%a IN ( Archivo3*.txt ) DO (
                   copy %%a "C:\DocumentosDeServidorA\Archivo3\Backup" ) >>C:\LOG\logwinscp_%dia%.txt

"C:\Program Files (x86)\WinSCP\WinSCP.com" /command "Open sesionftp" "CD /EntradaServidorB" "Put ""C:\DocumentosDeServidorA\Archivo1\TEMP\*.*"" -delete" "Put ""C:\DocumentosDeServidorA\Archivo2\TEMP\*.*"" -delete" "Put ""C:\DocumentosDeServidorA\Archivo3\TEMP\*.*"" -delete" "exit" >>C:\LOG\logwinscp_%dia%.txt

EXIT
