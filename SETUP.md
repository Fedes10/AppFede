# 🚀 Setup del Proyecto DeleFede en Nuevos Ordenadores

## Problema Original
El proyecto estaba configurado con rutas de Java hardcodeadas que no funcionaban en diferentes ordenadores.

## Solución ✅
Utilizamos **`local.properties`** (específico de cada ordenador, NO se commitea en GitHub) + **script de setup automático**.

## ¿Qué hacer cuando clonas el repo en un nuevo ordenador Windows?

### ⭐ LO MÁS FÁCIL:

**Simplemente hacer DOBLE-CLICK en:**
```
ABRE-ESTO-Configurar-Gradle.bat
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

---

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
- **`ABRE-ESTO-Configurar-Gradle.bat`** ← ⭐ ESTE (script automático para Windows)

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

¡Listo! Solo doble-click en `ABRE-ESTO-Configurar-Gradle.bat` y olvídate de los problemas de configuración. 🎉
