// Bump de versión para NutriPlato.
//
// Fuente única de verdad: `pubspec.yaml` (versión SemVer `MAJOR.MINOR.PATCH+BUILD`).
// Este script:
//   1. Lee la versión actual del pubspec.
//   2. Calcula la nueva según el segmento pedido (major/minor/patch).
//   3. Actualiza `pubspec.yaml` y `CHANGELOG.md` (mueve [No publicado] a la nueva versión).
//   4. Crea commit `chore: release vX.Y.Z` y tag `vX.Y.Z`.
//
// Uso:
//   dart run tool/bump_version.dart patch                # 3.0.0+4 -> 3.0.1+5
//   dart run tool/bump_version.dart minor                # 3.0.1+5 -> 3.1.0+6
//   dart run tool/bump_version.dart major                # 3.1.0+6 -> 4.0.0+7
//   dart run tool/bump_version.dart patch --build 12     # fija el versionCode
//   dart run tool/bump_version.dart --set 4.2.0+20       # versión exacta
//   dart run tool/bump_version.dart patch --dry-run      # simula sin escribir
//   dart run tool/bump_version.dart patch --no-tag       # sin tag
//   dart run tool/bump_version.dart patch --allow-dirty  # permite árbol sucio
//
// Seguridad: este script nunca toca `key.properties`, certificados ni secretos.

import 'dart:io';

const String _pubspecPath = 'pubspec.yaml';
const String _changelogPath = 'CHANGELOG.md';
const String _linksMarker = '<!-- __VERSION_LINKS__ -->';

class SemVer {
  final int major;
  final int minor;
  final int patch;
  final int build;

  const SemVer(this.major, this.minor, this.patch, this.build);

  /// `3.0.1+5`
  String get full => '$major.$minor.$patch+$build';

  /// `3.0.1`
  String get name => '$major.$minor.$patch';

  /// `v3.0.1`
  String get tag => 'v$name';

  @override
  String toString() => full;
}

void _log(String message) => stdout.writeln('==> $message');

Never _fail(String message) {
  stderr.writeln('ERROR: $message');
  exit(1);
}

void _printUsage() {
  stdout.writeln(
    '''
Bump de versión SemVer para NutriPlato.

Uso:
  dart run tool/bump_version.dart <major|minor|patch> [opciones]
  dart run tool/bump_version.dart --set MAJOR.MINOR.PATCH[+BUILD] [opciones]

Opciones:
  --build <n>      Fija el número de build (versionCode Android). Debe crecer.
  --set <v>        Establece una versión exacta (alternativa al segmento).
  --dry-run        Simula los cambios sin modificar archivos ni git.
  --no-tag         No crea el tag git.
  --no-commit      No crea commit ni tag (solo actualiza los archivos).
  --allow-dirty    Permite el bump con cambios sin commitear.
  -h, --help       Muestra esta ayuda.

Reglas:
  - `+BUILD` es el versionCode de Android: SIEMPRE debe incrementarse.
    El script lo auto-incrementa en cada bump salvo que uses --build.
  - El árbol git debe estar limpio salvo --allow-dirty.
  - Nunca toca secretos (key.properties, *.jks, *.keystore).''',
  );
}

void main(List<String> args) {
  final segmentArg = <String>[];
  String? setVersion;
  int? buildArg;
  var dryRun = false;
  var noTag = false;
  var noCommit = false;
  var allowDirty = false;

  for (final arg in args) {
    switch (arg) {
      case '-h' || '--help':
        _printUsage();
        return;
      case '--dry-run':
        dryRun = true;
      case '--no-tag':
        noTag = true;
      case '--no-commit':
        noCommit = true;
      case '--allow-dirty':
        allowDirty = true;
      default:
        if (arg == 'major' || arg == 'minor' || arg == 'patch') {
          segmentArg.add(arg);
        } else if (arg.startsWith('--build=')) {
          buildArg = int.tryParse(arg.substring('--build='.length));
          if (buildArg == null) _fail('--build requiere un entero.');
        } else if (arg == '--build') {
          _fail('Usa --build=<n> (p. ej. --build=12).');
        } else if (arg.startsWith('--set=')) {
          setVersion = arg.substring('--set='.length);
        } else {
          _fail('Argumento desconocido: $arg');
        }
    }
  }

  if (segmentArg.isNotEmpty && setVersion != null) {
    _fail('No combines <major|minor|patch> con --set.');
  }
  if (segmentArg.length > 1) {
    _fail('Indica un solo segmento: major, minor o patch.');
  }

  final current = _readCurrentVersion();

  final next = setVersion != null
      ? _parseVersion(setVersion)
      : _bump(current, segmentArg.isEmpty ? 'patch' : segmentArg.first, buildArg);

  _log('Versión actual:   ${current.full}');
  _log('Versión nueva:    ${next.full} (${next.tag})');

  if (next.build < current.build) {
    _fail(
      'El build (versionCode) no puede disminuir: ${current.build} -> ${next.build}. '
      'Usa --build con un valor mayor.',
    );
  }
  if (next.full == current.full) {
    _fail('La versión no cambia. Revisa el segmento solicitado.');
  }

  if (!dryRun) {
    _checkCleanTree(allowDirty);
  }

  _log('Actualizando pubspec.yaml...');
  _updatePubspec(current, next, dryRun);
  _log('Actualizando CHANGELOG.md...');
  _updateChangelog(next, dryRun);

  if (dryRun) {
    _log('DRY RUN: no se escribió nada ni se creó tag.');
    return;
  }

  final repo = _runGit(['remote', 'get-url', 'origin'], quiet: true);

  if (noCommit) {
    _log('Listo (sin commit ni tag). Revisa los cambios y haz commit manual.');
    return;
  }

  _log('Creando commit "chore: release ${next.tag}"...');
  _runGit(['add', _pubspecPath, _changelogPath]);
  _runGit(['commit', '-m', 'chore: release ${next.tag}']);

  if (!noTag) {
    _log('Creando tag ${next.tag}...');
    _runGit(['tag', '-a', next.tag, '-m', 'Release ${next.tag}']);
  }

  _log('Completado. Siguiente paso:');
  _log('  git push && git push origin ${next.tag}');
  _log(repo);
}

SemVer _readCurrentVersion() {
  if (!File(_pubspecPath).existsSync()) {
    _fail('No se encontró $_pubspecPath.');
  }
  final line = File(_pubspecPath)
      .readAsLinesSync()
      .firstWhere((l) => l.trimLeft().startsWith('version:'), orElse: () => '');
  final m = RegExp(
    r'version:\s*(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?',
  ).firstMatch(line);
  if (m == null) {
    _fail('No se pudo parsear la versión en $_pubspecPath.');
  }
  return SemVer(
    int.parse(m.group(1)!),
    int.parse(m.group(2)!),
    int.parse(m.group(3)!),
    int.tryParse(m.group(4) ?? '') ?? 1,
  );
}

SemVer _parseVersion(String raw) {
  final m = RegExp(
    r'^(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$',
  ).firstMatch(raw);
  if (m == null) {
    _fail('Versión inválida: "$raw". Formato: MAJOR.MINOR.PATCH[+BUILD].');
  }
  return SemVer(
    int.parse(m.group(1)!),
    int.parse(m.group(2)!),
    int.parse(m.group(3)!),
    int.tryParse(m.group(4) ?? '') ?? 1,
  );
}

SemVer _bump(SemVer current, String segment, int? buildOverride) {
  var (major, minor, patch) = (current.major, current.minor, current.patch);
  switch (segment) {
    case 'major':
      major += 1;
      minor = 0;
      patch = 0;
    case 'minor':
      minor += 1;
      patch = 0;
    case 'patch':
      patch += 1;
    default:
      _fail('Segmento inválido: $segment');
  }
  // El build (versionCode) siempre debe crecer de forma monotónica.
  final build = buildOverride ?? current.build + 1;
  return SemVer(major, minor, patch, build);
}

String _updatePubspec(SemVer current, SemVer next, bool dryRun) {
  final file = File(_pubspecPath);
  final lines = file.readAsLinesSync();
  final out = lines
      .map((l) => l.trimLeft().startsWith('version:')
          ? '${RegExp(r'^(\s*)version:.*').firstMatch(l)!.group(1)!}version: '
              '${next.full}'
          : l)
      .toList();
  if (!dryRun) {
    file.writeAsStringSync('${out.join('\n')}\n');
  }
  return out.join('\n');
}

String _updateChangelog(SemVer next, bool dryRun) {
  if (!File(_changelogPath).existsSync()) {
    _fail('No se encontró $_changelogPath.');
  }
  final lines = File(_changelogPath).readAsLinesSync();
  final today = DateTime.now().toIso8601String().substring(0, 10);

  final unreleasedIdx = lines.indexWhere((l) => l.trim() == '## [No publicado]');
  if (unreleasedIdx == -1) {
    _fail('No se encontró la sección "## [No publicado]" en $_changelogPath.');
  }
  final nextVersionIdx = lines.indexWhere(
    (l) => l.startsWith('## [') && l != '## [No publicado]',
    unreleasedIdx + 1,
  );
  final bodyEnd =
      nextVersionIdx == -1 ? lines.length : nextVersionIdx;

  // Contenido previo de [No publicado], sin las líneas vacías de los extremos.
  final body = lines.sublist(unreleasedIdx + 1, bodyEnd);
  while (body.isNotEmpty && body.first.trim().isEmpty) {
    body.removeAt(0);
  }
  while (body.isNotEmpty && body.last.trim().isEmpty) {
    body.removeLast();
  }

  final releaseBlock = <String>[
    '## [No publicado]',
    '',
  ];
  final versionBlock = <String>[
    '## [${next.name}] - $today',
    '',
    if (body.isNotEmpty) ...body else '_Sin cambios registrados._',
    '',
  ];

  final header = lines.take(unreleasedIdx);
  final tail = nextVersionIdx == -1
      ? <String>[]
      : lines.sublist(nextVersionIdx);

  final links = _buildVersionLinks(lines, next);

  final out = [
    ...header,
    ...releaseBlock,
    '',
    ...versionBlock,
    ...tail
        .where((l) =>
            l.trim() != _linksMarker &&
            !(l.startsWith('[') && l.contains('http'))),
    _linksMarker,
    ...links,
    '',
  ];

  if (!dryRun) {
    File(_changelogPath).writeAsStringSync('${out.join('\n')}\n');
  }
  return out.join('\n');
}

/// Reconstruye el bloque de enlaces al pie del changelog.
List<String> _buildVersionLinks(List<String> lines, SemVer next) {
  final versions = <SemVer>[
    next,
    ...lines
        .map((l) =>
            RegExp(r'^## \[(\d+)\.(\d+)\.(\d+)\]').firstMatch(l))
        .whereType<RegExpMatch>()
        .map((m) => SemVer(
              int.parse(m.group(1)!),
              int.parse(m.group(2)!),
              int.parse(m.group(3)!),
              0,
            )),
  ];
  versions.sort((a, b) {
    if (a.major != b.major) return b.major.compareTo(a.major);
    if (a.minor != b.minor) return b.minor.compareTo(a.minor);
    return b.patch.compareTo(a.patch);
  });
  // Deduplicar por nombre.
  final unique = <String, SemVer>{for (final v in versions) v.name: v}.values.toList();

  final repo = _repoBaseUrl();
  final out = <String>[
    if (unique.isNotEmpty)
      '[No publicado]: $repo/compare/${unique.first.tag}...HEAD',
    for (var i = 0; i < unique.length; i++)
      if (i == unique.length - 1)
        '[${unique[i].name}]: $repo/releases/tag/${unique[i].tag}'
      else
        '[${unique[i].name}]: $repo/compare/${unique[i + 1].tag}...${unique[i].tag}',
  ];
  return out;
}

String _repoBaseUrl() {
  final raw = _runGit(['remote', 'get-url', 'origin'], quiet: true);
  var url = raw.trim();
  if (url.endsWith('.git')) {
    url = url.substring(0, url.length - 4);
  }
  if (url.startsWith('git@')) {
    // git@host:user/repo -> https://host/user/repo
    url = url
        .replaceFirst('git@', 'https://')
        .replaceFirst(RegExp(r':'), '/');
  }
  return url;
}

void _checkCleanTree(bool allowDirty) {
  final status = _runGit(['status', '--porcelain'], quiet: true);
  if (status.trim().isNotEmpty && !allowDirty) {
    _fail(
      'El árbol de trabajo tiene cambios sin commitear.\n'
      '  - Haz commit de tus cambios primero, o\n'
      '  - usa --allow-dirty para forzar el bump.',
    );
  }
}

String _runGit(List<String> args, {bool quiet = false}) {
  final result = Process.runSync('git', args);
  if (result.exitCode != 0) {
    final err = (result.stderr as String).trim();
    if (!quiet || err.isNotEmpty) {
      _fail('git ${args.join(' ')} falló: ${err.isEmpty ? result.stdout : err}');
    }
  }
  return (result.stdout as String).trim();
}
