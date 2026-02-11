# Script para configurar automaticamente local.properties con la ruta correcta de Java
# Ejecutar: .\setup-gradle.ps1

Write-Host "=== Configurador Automático de Gradle ===" -ForegroundColor Green
Write-Host ""

# Función para buscar Java en ubicaciones comunes
function Find-JavaHome {
    $locations = @(
        "C:\Program Files\Android\Android Studio\jbr",
        "C:\Program Files\Java",
        "C:\Program Files (x86)\Java",
        "$env:JAVA_HOME",
        "C:\android-sdk\jdk"
    )
    
    foreach ($path in $locations) {
        if (Test-Path "$path\bin\java.exe") {
            Write-Host "[OK] Encontrada instalacion de Java en: $path" -ForegroundColor Green
            return $path
        }
    }
    
    # Busqueda recursiva en Program Files como ultimo recurso
    Write-Host "Buscando Java en Program Files..." -ForegroundColor Yellow
    $found = Get-ChildItem -Path "C:\Program Files" -Filter "jbr" -Directory -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        Write-Host "[OK] Encontrada instalacion de Java en: $($found.FullName)" -ForegroundColor Green
        return $found.FullName
    }
    
    $found = Get-ChildItem -Path "C:\Program Files" -Filter "jdk*" -Directory -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        Write-Host "[OK] Encontrada instalacion de Java en: $($found.FullName)" -ForegroundColor Green
        return $found.FullName
    }
    
    return $null
}

# Buscar Java
$javaHome = Find-JavaHome

if ($null -eq $javaHome) {
    Write-Host "[ERROR] No se encontro una instalacion de Java valida" -ForegroundColor Red
    Write-Host "Por favor, instala Java JDK 21 o posterior" -ForegroundColor Yellow
    exit 1
}

# Verificar version de Java
Write-Host ""
Write-Host "Verificando version de Java..." -ForegroundColor Cyan
$javaVersion = & "$javaHome\bin\java.exe" -version 2>&1
Write-Host $javaVersion[0] -ForegroundColor Gray

# Actualizar local.properties
$localPropertiesPath = Join-Path $PSScriptRoot "local.properties"
$javaHomeForward = $javaHome -replace '\\', '/'

Write-Host ""
Write-Host "Actualizando local.properties..." -ForegroundColor Cyan

if (Test-Path $localPropertiesPath) {
    $content = Get-Content $localPropertiesPath -Raw
    # Remover la linea anterior de java.home si existe
    $content = $content -replace '(?m)^# org\.gradle\.java\.home=.*$', ''
    $content = $content -replace '(?m)^org\.gradle\.java\.home=.*$', ''
    
    # Agregar la nueva linea (despues de sdk.dir)
    if ($content -match 'sdk\.dir=') {
        $content = $content -replace '(sdk\.dir=.*)', "`$1`n`n# Path to JDK (detected and configured automatically)`norg.gradle.java.home=$javaHomeForward"
    } else {
        $content = $content + "`n# Path to JDK (detected and configured automatically)`norg.gradle.java.home=$javaHomeForward"
    }
    
    Set-Content -Path $localPropertiesPath -Value $content
    Write-Host "[OK] local.properties actualizado" -ForegroundColor Green
} else {
    Write-Host "[ERROR] No se encontro local.properties" -ForegroundColor Red
    exit 1
}

# Configurar JAVA_HOME en variables de entorno del usuario
Write-Host ""
Write-Host "Configurando variable de entorno JAVA_HOME..." -ForegroundColor Cyan
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
$env:JAVA_HOME = $javaHome
Write-Host "[OK] JAVA_HOME configurada: $javaHome" -ForegroundColor Green

# Limpiar cache de Gradle
Write-Host ""
Write-Host "Limpiando cache de Gradle..." -ForegroundColor Cyan
if (Test-Path ".gradle") {
    Remove-Item ".gradle" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] Cache de Gradle limpiado" -ForegroundColor Green
}

# Verificar que Gradle funciona
Write-Host ""
Write-Host "Verificando que Gradle funciona..." -ForegroundColor Cyan
$gradleVersion = & ".\gradlew.bat" --version 2>&1 | Select-String "Gradle"
if ($gradleVersion) {
    Write-Host "[OK] $gradleVersion" -ForegroundColor Green
    Write-Host ""
    Write-Host "=== Configuracion completada exitosamente! ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Puedes ejecutar: .\gradlew.bat build" -ForegroundColor Yellow
} else {
    Write-Host "[ERROR] Error verificando Gradle" -ForegroundColor Red
    exit 1
}
