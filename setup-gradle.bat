@echo off
REM Script para configurar automaticamente local.properties con la ruta correcta de Java
REM Simplemente hacer doble-click en este archivo para ejecutar

setlocal enabledelayedexpansion

echo.
echo === Configurador Automatico de Gradle ===
echo.

REM Buscar Java en Android Studio
set JAVA_PATH=C:\Program Files\Android\Android Studio\jbr
if exist "%JAVA_PATH%\bin\java.exe" (
    echo Encontrada instalacion de Java en Android Studio
    goto :found
)

REM Buscar JDK en Program Files
for /d %%i in ("C:\Program Files\Java\jdk*") do (
    if exist "%%i\bin\java.exe" (
        set JAVA_PATH=%%i
        echo Encontrada instalacion de Java: !JAVA_PATH!
        goto :found
    )
)

REM Si no lo encontro, avisar
echo ERROR: No se encontro una instalacion valida de Java
echo Por favor, instala Java JDK 21 o usa Android Studio
pause
exit /b 1

:found
REM Convertir backslashes a forward slashes para gradle
set JAVA_PATH_FORWARD=%JAVA_PATH:\=/%

REM Actualizar local.properties
echo.
echo Actualizando local.properties...

REM Crear local.properties con la configuracion correcta
(
    echo ## This file must *NOT* be checked into Version Control Systems,
    echo # as it contains information specific to your local configuration.
    echo #
    echo # Location of the SDK. This is only used by Gradle.
    echo # For customization when using a Version Control System, please read the
    echo # header note.
    echo.
    echo sdk.dir=C:\\Users\\fedet\\AppData\\Local\\Android\\Sdk
    echo.
    echo # Path to JDK (detected and configured automatically^)
    echo org.gradle.java.home=%JAVA_PATH_FORWARD%
) > local.properties

echo Configuracion completada.
echo.
echo ============================================
echo Ahora puedes ejecutar: gradlew.bat build
echo ============================================
pause
