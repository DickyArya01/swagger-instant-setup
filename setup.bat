@echo off

:: Tambahkan package Swashbuckle.AspNetCore untuk Swagger
echo Adding Swagger package...
dotnet add package Swashbuckle.AspNetCore

:: Tambahkan package Newtonsoft.Json
echo Adding Newtonsoft.Json package...
dotnet add package Newtonsoft.Json

:: Path ke file Program.cs dan temp.txt
set PROGRAM_FILE=%~dp0Program.cs
set TEMP_FILE=%~dp0templateSwagger.txt
set SHARED_LIBRARY_DIR=%~dp0SharedLibrary
set PROJECT_FILE=

:: Cari file .csproj di folder ini secara otomatis
for %%f in ("%~dp0*.csproj") do set PROJECT_FILE=%%f

:: Debugging: Periksa jalur file
echo Checking for file: "%PROGRAM_FILE%"

:: Periksa apakah file Program.cs ada
if exist "%PROGRAM_FILE%" (
    echo Updating Program.cs...

    :: Salin isi temp.txt ke Program.cs tanpa menghapus temp.txt
    copy /y "%TEMP_FILE%" "%PROGRAM_FILE%" >nul

    echo Program.cs updated successfully.
) else (
    echo Program.cs not found. Please ensure you are running this script in the correct directory.
)

:: Periksa apakah SharedLibrary sudah ada, jika tidak buat baru
if not exist "%SHARED_LIBRARY_DIR%" (
    echo Creating SharedLibrary project...
    dotnet new classlib -o SharedLibrary
) else (
    echo SharedLibrary already exists.
)

:: Tambahkan referensi SharedLibrary ke proyek utama jika .csproj ditemukan
if defined PROJECT_FILE (
    echo Adding SharedLibrary reference to %PROJECT_FILE%...
    dotnet add "%PROJECT_FILE%" reference SharedLibrary/SharedLibrary.csproj
) else (
    echo No .csproj file found! Ensure you are in the correct project directory.
)

echo Setup complete.
pause
