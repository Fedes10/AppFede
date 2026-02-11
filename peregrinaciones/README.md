# Peregrinaciones

Archivo: `peregrinaciones.json`

## Campos de cada peregrinación

| Campo | Descripción |
|-------|-------------|
| `id` | Identificador único (ej: "peregrinacion-fatima-2025") |
| `nombre` | Nombre de la peregrinación |
| `descripcion` | Descripción corta |
| `fecha_salida` | Fecha de salida (YYYY-MM-DD) |
| `fecha_regreso` | Fecha de regreso (YYYY-MM-DD) |
| `precio` | Precio (ej: "150€" o "Gratuito") |
| `requisitos` | Requisitos de edad, documentación, etc. |
| `inscripcion_apertura` | Fecha apertura inscripciones |
| `inscripcion_cierre` | Fecha cierre inscripciones |
| `plazas` | Número de plazas disponibles |
| `enlace_inscripcion` | URL del formulario Google Forms |
| `imagen_portada` | Imagen principal |
| `imagenes` | Galería de imágenes (separadas por coma) |
| `color_tema` | Color hexadecimal para UI |

## Añadir peregrinación

1. Añade un objeto nuevo al array `peregrinaciones`
2. Sube imagen a `peregrinaciones/images/`
3. Crea formulario en Google Forms y copia el enlace
4. Actualiza `ultima_actualizacion`

## Imágenes

- Formato: JPG o PNG
- Tamaño portada: 1200x800px
- Carpeta: `peregrinaciones/images/`
