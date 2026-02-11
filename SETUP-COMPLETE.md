# 🚀 Setup del Proyecto DeleFede - Solución Multi-Ordenador

## Problemas Resueltos ✅

Este documento explica cómo se ha resuelto el problema de trabajar en dos ordenadores con configuraciones diferentes.

### Problemas Originales
1. **Java Path hardcodeado**: Ruta de Java diferente en casa vs empresa
2. **Gradle Cache en Windows**: Problemas de permisos (`AccessDeniedException`)
3. **Sincronización entre ordenadores**: Cambios no compatibles en cada máquina

### Soluciones Implementadas

```
✓ Separación: gradle.properties (compartido) vs local.properties (específico)
✓ Cache local: Gradle usa .gradle del proyecto, no del perfil de Windows
✓ Scripts inteligentes: ConfigOrdenadorEmpresa.bat vs ConfigOrdenadorCasa.bat
✓ Limpieza automática: Se elimina cache problemático de Windows
✓ Configuración Windows: workers.max=1, parallel=false para evitar locks
```

---

## Uso en EMPRESA (Este Ordenador - Actual)

### Setup Inicial (ya hecho, pero si necesitas repetir):

```batch
ABRE-ESTO-Configurar-Gradle.bat
→ Escribe [1] EMPRESA
```

El script hace:
1. Configura `local.properties` con rutas de EMPRESA
2. Limpia daemon de Gradle
3. Borra cache problemático de Windows (`%USERPROFILE%\.gradle\caches`)
4. Listo para compilar

### Compilar después:

```bash
./gradlew build
```

O desde Android Studio: `Build → Build App`

---

## Configuración de EMPRESA (Hardcodeada)

```batch
# ConfigOrdenadorEmpresa.bat
JAVA_PATH=C:\Program Files\Android\Android Studio\jbr
SDK_PATH=C:\Users\PRACTICAS2026\AppData\Local\Android\Sdk
GRADLE_USER_HOME=%CD%\.gradle
```

Estos valores están fijos en el script de empresa, sin necesidad de editar.

---

## Configuración en gradle.properties (Compartida)

```gradle
# Usa cache LOCAL (evita problemas de permisos en Windows)
org.gradle.user.home=.gradle

# Optimizaciones para Windows
org.gradle.parallel=false
org.gradle.workers.max=1
org.gradle.caching=false
org.gradle.configuration-cache=false
```

**¿Por qué?** 
- Gradle normally usa `C:\Users\<user>\.gradle\caches` (global)
- Windows a veces bloquea esos archivos → `AccessDeniedException`
- Solución: Usar `.gradle` local en el proyecto (ignorado por Git)

---

## En CASA (Futuro)

### Primera vez:

1. Doble-click en `ABRE-ESTO-Configurar-Gradle.bat`
2. Escribe `[2] CASA`
3. Sigue las instrucciones:
   ```
   - Abre PowerShell
   - Ejecuta: java -version
   - Encuentra dónde está Android SDK
   - Edita ConfigOrdenadorCasa.bat
   ```

4. Relena los valores:
   ```batch
   set JAVA_PATH=C:\Tu\Ruta\A\Java
   set SDK_PATH=C:\Tu\Ruta\A\Android\Sdk
   ```

5. Vuelve a correr el script, escribe `[2] CASA`

### Después:

```bash
./gradlew build
```

---

## Archivos del Sistema

### En GitHub (Compartidos)
- `gradle.properties` - Configuración con soluciones Windows
- `gradle/wrapper/gradle-wrapper.properties` - Versión de Gradle (8.11)
- `ABRE-ESTO-Configurar-Gradle.bat` - Script de menú
- `ConfigOrdenadorEmpresa.bat` - Configuración lista para EMPRESA
- `ConfigOrdenadorCasa.bat` - Plantilla para CASA

### NO en GitHub (Específicos de cada PC)
- `local.properties` - Rutas de Java y SDK (`.gitignore`)
- `.gradle/` - Cache de Gradle local (`.gitignore`)

---

## Troubleshooting

### Error: `Could not move temporary workspace`
**Causa**: Cache de Gradle corrupto
**Solución**: `ConfigOrdenadorEmpresa.bat` ya lo hace automáticamente

Si aún falla:
```powershell
./gradlew --stop
Remove-Item C:\Users\%USERNAME%\.gradle\caches -Recurse -Force
./gradlew clean
```

### Error: `JAVA_HOME is not set`
**Solución**: Ejecuta `ConfigOrdenadorEmpresa.bat` nuevamente

### Error: `SDK not found`
**Solución**: Edita `local.properties`:
```properties
sdk.dir=C:\Ruta\Correcta\Al\Android\Sdk
```

---

## Resumen Rápido

| Acción | Comando |
|--------|---------|
| **Setup inicial** | `ABRE-ESTO-Configurar-Gradle.bat` → `[1]` |
| **Compilar** | `./gradlew build` |
| **Limpiar** | `./gradlew clean` |
| **Desde Android Studio** | `Build → Build App` |

---

## ¿Por qué esta estructura?

**Antes**: Un único usuario con rutas hardcodeadas = falla en otro PC

**Ahora**: 
- Código compartido en GitHub ✅
- Configuración específica local (`.gitignore`) ✅
- Scripts que configuran automáticamente ✅
- Solución de problema Windows de Gradle ✅

**Resultado**: Clonas el repo, ejecutas un script, funciona. 🎉
