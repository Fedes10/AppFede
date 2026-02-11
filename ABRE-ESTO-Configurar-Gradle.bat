@echo off
REM ============================================
REM ABRE ESTE ARCHIVO HACIENDO DOBLE-CLICK
REM Para configurar automaticamente Gradle
REM ============================================

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo   SELECTOR DE CONFIGURACION
echo ==========================================
echo.
echo Elige donde quieres usar esta app:
echo.
echo [1] EMPRESA
echo [2] CASA
echo.

set /p opcion="Escribe 1 o 2: "

if "%opcion%"=="1" (
    call ConfigOrdenadorEmpresa.bat
) else if "%opcion%"=="2" (
    call ConfigOrdenadorCasa.bat
) else (
    echo [ERROR] Opcion invalida
    pause
    exit /b 1
)
