# Versionado

Este documento define la política de versionado de NutriPlato: SemVer, fuente
única de verdad, flujo de release, changelog y medidas de seguridad.

## SemVer + versionCode

La versión usa [Versionado Semántico](https://semver.org/lang/es/) con un
sufijo de build:

```
MAJOR.MINOR.PATCH+BUILD
```

| Segmento | Significado |
|----------|-------------|
| `MAJOR` | Cambios incompatibles o lanzamientos con funcionalidad nueva relevante. |
| `MINOR` | Funcionalidad nueva compatible. |
| `PATCH` | Correcciones de errores compatibles. |
| `BUILD`  | Número de compilación (versionCode de Android). **Debe crecer siempre.** |

### La regla de oro del `BUILD`

En Android, `versionCode` debe ser estrictamente creciente entre publicaciones
(Play Store lo rechaza si disminuye). Por eso `BUILD` **nunca se reinicia**:
cada bump suma `+1`, salvo que lo fijes explícitamente con `--build`.

## Fuente única de verdad

`pubspec.yaml` es la única fuente de verdad de la versión:

```yaml
version: 3.0.0+4
```

Todas las plataformas la derivan automáticamente en build:

- **Android**: `versionName` (SemVer) y `versionCode` (`+BUILD`) se leen de
  `pubspec.yaml` vía `local.properties` → `android/app/build.gradle`.
- **Web**: manifest y service worker.
- **Windows / Linux**: metadatos de versión generados por el tooling de Flutter.

> No edites `versionCode`/`versionName` a mano en `build.gradle`. Siempre
> haz el bump desde `pubspec.yaml` (idealmente con el script).

## Flujo de release

### 1. Acumula cambios

Escribe cada cambio en `CHANGELOG.md`, bajo `## [No publicado]`, usando las
categorías de [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/):

- `### Añadido`
- `### Cambiado`
- `### Deprecado`
- `### Eliminado`
- `### Corregido`
- `### Seguridad`

### 2. Haz el bump

```bash
dart run tool/bump_version.dart patch                # 3.0.0+4 -> 3.0.1+5
dart run tool/bump_version.dart minor                # 3.0.1+5 -> 3.1.0+6
dart run tool/bump_version.dart major                # 3.1.0+6 -> 4.0.0+7
dart run tool/bump_version.dart patch --build=12     # fija versionCode
dart run tool/bump_version.dart --set=4.2.0+20       # versión exacta
```

El script:

1. Valida SemVer y que `BUILD` no disminuya.
2. Actualiza `pubspec.yaml`.
3. Mueve el contenido de `[No publicado]` a la nueva versión fechada en
   `CHANGELOG.md` y regenera los enlaces de comparación.
4. Crea el commit `chore: release vX.Y.Z` y el tag anotado `vX.Y.Z`.

> Exige un árbol git limpio. Para forzar: `--allow-dirty`.
> Simula primero: `--dry-run`. Omite tag/commit: `--no-tag` / `--no-commit`.

### 3. Publica

```bash
git push
git push origin v3.0.1
```

## Changelog

- `CHANGELOG.md` sigue **Keep a Changelog**.
- El idioma es **español** (consistente con README y UI).
- Las entradas se escriben bajo `[No publicado]` y el bump las promueve a la
  versión con fecha ISO 8601 (`YYYY-MM-DD`).
- Una entrada describe el *porqué* y el *impacto*, no un copia-pega del diff.

## Seguridad

- Los secretos (`key.properties`, `*.jks`, `*.keystore`, `*.p12`, `*.pem`,
  `.env`) están en `.gitignore` y el hook de `pre-commit` **bloquea** su commit.
- El script de bump **nunca** lee ni escribe `key.properties` ni certificados.
- El firma del APK de release se lee en tiempo de build desde
  `android/key.properties` (fuera del repositorio); no se comitean credenciales.

## Hooks de git

Instala una vez:

```bash
./tools/install-hooks.sh
```

El hook `pre-commit`:

- Bloquea secretos.
- Exige `CHANGELOG.md` actualizado cuando cambia código de la app
  (`lib/`, plataformas, `test/`, `pubspec.yaml`).

Escapatoria consciente (solo cuando corresponde):

```bash
git commit --no-verify
```
