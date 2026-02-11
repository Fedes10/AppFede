# 🚀 Setup del Proyecto DeleFede en Nuevos Ordenadores

## Problema Original
El proyecto estaba configurado con rutas de Java hardcodeadas que no funcionaban en diferentes ordenadores.

## Solución ✅
Utilizamos **`local.properties`** (específico de cada ordenador, NO se commitea en GitHub) + **scripts de setup automático**.

## ¿Qué hacer cuando clonas el repo en un nuevo ordenador?

### Opción 1: Script Automático (⭐ RECOMENDADO - Lo más fácil)

**En Windows:**
```bash
# Solo hacer doble-click en este archivo:
setup-gradle.bat
```

O desde PowerShell:
```powershell
.\setup-gradle.ps1
```

**En Linux/Mac:**
```bash
chmod +x setup-gradle.sh
./setup-gradle.sh
```

El script hace automáticamente:
- ✓ Detecta dónde está instalado Java en tu ordenador
- ✓ Configura `local.properties` con la ruta correcta
- ✓ Establece la variable de entorno `JAVA_HOME`
- ✓ Limpia el caché de Gradle
- ✓ Verifica que todo funciona

Después simplemente ejecuta:
```bash
./gradlew build
```

### Opción 2: Manual

Si el script no funciona, edita `local.properties` manualmente:

```properties
sdk.dir=C:\Users\TuUsuario\AppData\Local\Android\Sdk
org.gradle.java.home=C:/Ruta/A/Tu/Java/JDK21
```

## ¿Dónde está Java en mi ordenador?

### Android Studio (⭐ Opción más común)
```
C:\Program Files\Android\Android Studio\jbr
```

### JDK instalado independientemente
```
C:\Program Files\Java\jdk-21
```

## Archivos Importantes

- **`gradle.properties`** ← En GitHub (configuración compartida)
- **`local.properties`** ← NO en GitHub (configuración específica de cada PC)
- **`local.properties.template`** ← Referencia de qué configurar
- **`setup-gradle.bat`** ← Script automático para Windows
- **`setup-gradle.ps1`** ← Script automático para PowerShell

## ⚠️ NO hagas commit de `local.properties`

Está en `.gitignore`, así que Git la ignorará automáticamente. Cada ordenador tendrá su propia versión.

## Troubleshooting

**Si el script no encuentra Java:**
- Instala Android Studio (incluye Java JDK 21)
- O descarga JDK 21 manualmente desde: https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html

**Si aún tienes problemas:** 
- Abre una terminal
- Ejecuta: `java -version`
- Si no funciona, instala Java primero

---

¡Listo! Solo ejecuta el script una vez por ordenador y olvídate de los problemas de configuración. 🎉
