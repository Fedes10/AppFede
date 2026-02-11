#!/bin/bash

# Script para configurar automaticamente local.properties con la ruta correcta de Java
# Ejecutar: chmod +x setup-gradle.sh && ./setup-gradle.sh

echo ""
echo "=== Configurador Automático de Gradle ==="
echo ""

# Función para buscar Java
find_java_home() {
    local possible_locations=(
        "/usr/libexec/java_home"
        "/usr/local/opt/openjdk@21/bin/java"
        "/opt/android-studio/jbr"
        "$HOME/Library/Android/sdk/ndk-bundle/jdk"
        "/usr/bin/java"
        "/opt/java/openjdk"
    )
    
    # Intentar con /usr/libexec/java_home en macOS
    if command -v /usr/libexec/java_home &> /dev/null; then
        JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
        if [ -n "$JAVA_HOME" ]; then
            echo "✓ Encontrada instalación de Java: $JAVA_HOME"
            return 0
        fi
    fi
    
    # Buscar en ubicaciones comunes
    for path in "${possible_locations[@]}"; do
        if [ -f "$path" ] || [ -d "$path" ]; then
            if [ -d "$path" ]; then
                path="$path"
            else
                path=$(dirname "$(dirname "$path")")
            fi
            
            if [ -x "$path/bin/java" ]; then
                JAVA_HOME="$path"
                echo "✓ Encontrada instalación de Java: $JAVA_HOME"
                return 0
            fi
        fi
    done
    
    # Si no se encontró en ubicaciones comunes, buscar con which
    if command -v java &> /dev/null; then
        local java_bin=$(which java)
        JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$java_bin")")")
        if [ -x "$JAVA_HOME/bin/java" ]; then
            echo "✓ Encontrada instalación de Java: $JAVA_HOME"
            return 0
        fi
    fi
    
    return 1
}

# Buscar Java
if ! find_java_home; then
    echo "✗ No se encontró una instalación de Java válida"
    echo "Por favor, instala Java JDK 21 o posterior"
    exit 1
fi

# Verificar versión de Java
echo ""
echo "Verificando versión de Java..."
"$JAVA_HOME/bin/java" -version 2>&1 | head -1

# Detectar el directorio de Android SDK
find_android_sdk() {
    local possible_sdk_locations=(
        "$HOME/Library/Android/sdk"
        "$HOME/Android/Sdk"
        "$HOME/.android/sdk"
        "/opt/android-sdk"
    )
    
    for path in "${possible_sdk_locations[@]}"; do
        if [ -d "$path" ]; then
            ANDROID_SDK_PATH="$path"
            echo "✓ Encontrado Android SDK: $ANDROID_SDK_PATH"
            return 0
        fi
    done
    
    return 1
}

# Buscar SDK
echo ""
echo "Buscando Android SDK..."
if find_android_sdk; then
    SDK_LINE="sdk.dir=$ANDROID_SDK_PATH"
else
    echo "⚠ No se encontró Android SDK automáticamente"
    echo "Intenta configurarlo manualmente en local.properties"
    SDK_LINE="# sdk.dir=/ruta/a/tu/Android/Sdk"
fi

# Actualizar local.properties
echo ""
echo "Actualizando local.properties..."

cat > local.properties << EOF
## This file must *NOT* be checked into Version Control Systems,
# as it contains information specific to your local configuration.
#
# Location of the SDK. This is only used by Gradle.
# For customization when using a Version Control System, please read the
# header note.

$SDK_LINE

# Path to JDK (detected and configured automatically)
org.gradle.java.home=$JAVA_HOME
EOF

if [ $? -eq 0 ]; then
    echo "✓ local.properties actualizado"
else
    echo "✗ Error actualizando local.properties"
    exit 1
fi

# Configurar JAVA_HOME en el shell actual y permanentemente
echo ""
echo "Configurando variable de entorno JAVA_HOME..."
export JAVA_HOME="$JAVA_HOME"

# Agregar a .bashrc o .zshrc según el shell actual
if [ -n "$ZSH_VERSION" ]; then
    if ! grep -q "export JAVA_HOME" ~/.zshrc 2>/dev/null; then
        echo "export JAVA_HOME='$JAVA_HOME'" >> ~/.zshrc
        echo "✓ JAVA_HOME agregado a ~/.zshrc"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if ! grep -q "export JAVA_HOME" ~/.bashrc 2>/dev/null; then
        echo "export JAVA_HOME='$JAVA_HOME'" >> ~/.bashrc
        echo "✓ JAVA_HOME agregado a ~/.bashrc"
    fi
fi

echo "✓ JAVA_HOME configurado: $JAVA_HOME"

# Limpiar caché de Gradle
echo ""
echo "Limpiando caché de Gradle..."
if [ -d ".gradle" ]; then
    rm -rf .gradle
    echo "✓ Caché de Gradle limpiado"
fi

# Verificar que Gradle funciona
echo ""
echo "Verificando que Gradle funciona..."
if ./gradlew --version 2>&1 | grep -q "Gradle"; then
    echo "✓ Gradle funciona correctamente"
    echo ""
    echo "=== ¡Configuración completada exitosamente! ==="
    echo ""
    echo "Puedes ejecutar: ./gradlew build"
else
    echo "✗ Error verificando Gradle"
    exit 1
fi
