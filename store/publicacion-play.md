# Publicación en Google Play — NutriPlato v3.2.0+8

Artefacto para subir: `build/app/outputs/bundle/release/app-release.aab`
(versionCode 8, versionName 3.2.0 — superior al live 3.1.1+7).

## Estado actual (2026-10-08)

| Paso | Estado |
|---|---|
| Reset de upload key | **Solicitado y aprobado** (razón: llave perdida) |
| Ventana de subida abierta | **2026-10-10 23:50:53 UTC** (por política de Google) |
| Subida del AAB | **Programada** con `nutriplato-play-upload.timer` a las 23:55 UTC → deja borrador |
| Store listing nuevo | **En revisión de Google** (descripciones + 7 capturas + feature graphic) |
| Rollout a producción | Manual: revisar borrador y "Start rollout to Production" |

## 1. Firma (ya resuelto)

La app usa Play App Signing (activo). El AAB va firmado con el keystore nuevo
`/home/sazar/keystores/nutriplato-upload.jks`; Google ya aprobó el reset y la
clave entra en vigor el **2026-10-10 23:50:53 UTC**.

> Guarda un respaldo del keystore y sus contraseñas en un lugar seguro
> (gestor de contraseñas + copia offline). Si se pierde otra vez, habrá que
> repetir este trámite.

## 2. Subida automática (ya programada)

- Script: `~/.local/share/nutriplato-upload/upload_release.mjs` (CDP sobre el
  Chromium automatizado con sesión de Google).
- Timer: `nutriplato-play-upload.timer` (systemd --user), 2026-10-10 23:55 UTC,
  `Persistent=true` (si el equipo está apagado, corre al encender).
- El script sube el AAB, detecta aceptación/rechazo de firma, rellena nombre
  (`3.2.0 (8)`) y notas, guarda **borrador** y envía notificación de escritorio.
- Log: `~/.local/share/nutriplato-upload/upload-YYYY-MM-DD.log`.
- Tras el borrador: Play Console → Producción → **Start rollout to Production**.

## 3. Checklist de assets (todos en `store/`)

| Asset | Requisito Play | Archivo |
|---|---|---|
| Ícono | 512×512 PNG | `store/icon-512.png` |
| Gráfico destacado | 1024×500 PNG/JPEG | `store/feature-graphic-1024x500.png` |
| Capturas de teléfono | 2–8, 9:16, min 320 px | `store/screenshots/` |
| ---------- | ---------- | ---------- |

Otros campos que ya existen en el listing actual (no hace falta tocarlos si ya
están): política de privacidad (`Política de Privacidad - NutriPlato.pdf`),
clasificación de contenido, público objetivo, seguridad de datos.

## 4. Textos del listing (es-MX)

**Nombre de la app (≤30):**
```
NutriPlato: Nutrición Mexicana
```

**Descripción breve (≤80):**
```
Plato del bien comer, calorías, ejercicios y guías. Nutrición mexicana real.
```

**Descripción completa (≤4000):**

```
NutriPlato te ayuda a comer mejor con la guía del Plato del Bien Comer
(NOM-043-SSA2-2012), 100% en español y pensado para México.

🥗 PLATO DEL BIEN COMER INTERACTIVO
Aprende las porciones correctas de verduras, frutas, cereales, leguminosas y
alimentos de origen animal tocando cada sección del plato. Descubre para qué
sirve cada grupo y cómo combinarlos en tu día.

🔥 REGISTRO DE ALIMENTOS Y CALORÍAS
Registra lo que comes en segundos: más de 1,400 alimentos con datos de
composición, y búsqueda en línea en OpenFoodFacts. NutriPlato calcula calorías,
macronutrientes y tu progreso diario.

🧮 PLAN PERSONALIZADO CON CIENCIA
Calculamos tu metabolismo basal (BMR), gasto energético (TDEE), calorías
objetivo, distribución de comidas, hidratación y proyección de peso según tu
perfil, actividad, condiciones de salud y alergias. Aplica tu plan al registro
del día con un toque.

📅 TU PREDICCIÓN DE HOY
Un motor inteligente te sugiere cada día qué comer, qué ejercicio hacer y qué
leer, según tu perfil y tu historial, evitando repeticiones.

🏋️ SMART FITNESS CON 108 EJERCICIOS
Rutinas de cardio, fuerza, core, flexibilidad, movilidad e HIIT con pasos,
tips, contraindicaciones y límites por IMC.

📚 APRENDE CADA DÍA
Más de 60 artículos sobre nutrición, recetas y menús, condiciones de salud,
estilo de vida y tradición gastronómica mexicana.

🎨 A TU ESTILO
8 temas de color, modo oscuro, accesibilidad WCAG 2.2 y funcionamiento sin
conexión para lo esencial.

Privacidad ante todo: tus datos se guardan en tu dispositivo.

NutriPlato es material educativo y no sustituye la asesoría de un profesional
de la salud.
```

**Novedades de la versión (≤500):**

```
Nuevo motor de predicción diaria: qué comer, entrenar y leer hoy. Más de 60
artículos nuevos y banco de ejercicios ampliado a 108. Plan personalizado al
final del onboarding, aplicable a tu registro con un toque. Mejoras de
accesibilidad (WCAG 2.2), contraste y navegación. Compatibilidad con Android 16.
```

## 5. Pasos finales en Play Console

1. **Producción → Crear versión nueva** (o prueba interna primero, recomendado).
2. Subir `app-release.aab`.
3. Pegar "Novedades de la versión".
4. Revisar que el resumen no muestre errores (targetSdk 36 ✔).
5. **Guardar → Revisar versión → Iniciar implementación**.
6. Revisión de Google: normalmente < 1 semana.

## 6. Notas de compatibilidad

- `targetSdkVersion 36` (Android 16): obligatorio para updates desde el
  31-ago-2026. Android 16 desactiva el opt-out de edge-to-edge y habilita
  predictive back por defecto; conviene probar en un dispositivo Android 15/16
  que no haya solapamientos con la barra de estado/navegación.
- El emulador local es Android 13; no cubre esos cambios.
