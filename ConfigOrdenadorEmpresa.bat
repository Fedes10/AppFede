@echo off
REM ============================================
REM CONFIGURACION DEL ORDENADOR EMPRESA
REM ============================================
REM Este script configura Gradle con las rutas
REM especificas del ordenador de la empresa

echo.
echo === Configurando para ORDENADOR EMPRESA ===
echo.

REM Rutas de EMPRESA (hardcodeadas)
set JAVA_PATH=C:\Program Files\Android\Android Studio\jbr
set SDK_PATH=C:\Users\PRACTICAS2026\AppData\Local\Android\Sdk

REM Verificar que Java existe
if not exist "%JAVA_PATH%\bin\java.exe" (
    echo ERROR: No se encontro Java en: %JAVA_PATH%
    echo Por favor, instala Android Studio
    pause
    exit /b 1
)

REM Convertir backslashes a forward slashes para gradle
set JAVA_PATH_FORWARD=%JAVA_PATH:\=/%

REM Crear local.properties con la configuracion de EMPRESA
echo Creando local.properties...

(
    echo ## This file must *NOT* be checked into Version Control Systems,
    echo # as it contains information specific to your local configuration.
    echo #
    echo # CONFIGURACION DEL ORDENADOR EMPRESA
    echo #
    echo sdk.dir=%SDK_PATH:\=\%
    echo.
    echo # Path to JDK (Ordenador Empresa^)
    echo org.gradle.java.home=%JAVA_PATH_FORWARD%
) > local.properties

echo.
echo [OK] Configuracion de EMPRESA aplicada
echo.
echo Datos configurados:
echo - Java: %JAVA_PATH%
echo - SDK: %SDK_PATH%
echo.
echo ============================================
echo Ahora puedes ejecutar: gradlew.bat build
echo ============================================
pause
