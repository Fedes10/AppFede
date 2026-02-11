# 🚀 Setup del Proyecto DeleFede en Nuevos Ordenadores

## Problema Original
El proyecto estaba configurado con rutas de Java hardcodeadas que no funcionaban en diferentes ordenadores.

## Solución ✅
Utilizamos **`local.properties`** (específico de cada ordenador, NO se commitea en GitHub) + **scripts de setup por ordenador**.

## ¿Qué hacer cuando clonas el repo en un nuevo ordenador Windows?

### ⭐ LO MÁS FÁCIL:

**Simplemente hacer DOBLE-CLICK en:**
```
ABRE-ESTO-Configurar-Gradle.bat
```

El script te pedirá que elijas:
```
[1] EMPRESA
[2] CASA
```

---

## En EMPRESA

Escoge opción `[1]` y el script automáticamente:
- ✓ Configura el Java de Android Studio
- ✓ Configura el SDK de Android
- ✓ Actualiza `local.properties` con las rutas correctas
- ✓ Verifica que todo funciona

---

## En CASA (Primera vez)

Escoge opción `[2]` y el script te dirá qué hacer:

1. Abre una terminal
2. Ejecuta: `java -version` (para saber dónde está Java)
3. Encuentra dónde está tu Android SDK
4. Edita el archivo `ConfigOrdenadorCasa.bat` y rellena:

```batch
set JAVA_PATH=C:\Ruta\A\Tu\Java
set SDK_PATH=C:\Ruta\A\Tu\Android\Sdk
```

Luego guarda y vuelve a ejecutar el script eligiendo `[2]`

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
- **`ABRE-ESTO-Configurar-Gradle.bat`** ← ⭐ ESTE (menú principal)
- **`ConfigOrdenadorEmpresa.bat`** ← Configuracion hardcodeada para empresa
- **`ConfigOrdenadorCasa.bat`** ← Plantilla para rellenar en casa

## ⚠️ NO hagas commit de `local.properties`

Está en `.gitignore`, así que Git la ignorará automáticamente. Cada ordenador tendrá su propia versión.

---

¡Listo! Solo doble-click en `ABRE-ESTO-Configurar-Gradle.bat` y olvídate de los problemas de configuración. 🎉
