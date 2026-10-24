import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PresidentDetailPage extends StatelessWidget {
  final Map<String, dynamic> president;

  const PresidentDetailPage({super.key, required this.president});

  String _formatLabel(String key) {
    const labels = {
      'name': 'Nombre',
      'lastName': 'Apellido',
      'last_name': 'Apellido',
      'startPeriodDate': 'Inicio del período presidencial',
      'endPeriodDate': 'Fin del período presidencial',
      'start_period_date': 'Inicio del período presidencial',
      'end_period_date': 'Fin del período presidencial',
      'politicalParty': 'Partido político',
      'political_party': 'Partido político',
      'description': 'Descripción',
      'birthDate': 'Fecha de nacimiento',
      'birth_date': 'Fecha de nacimiento',
      'birthPlace': 'Lugar de nacimiento',
      'birth_place': 'Lugar de nacimiento',
    };

    if (labels.containsKey(key)) {
      return labels[key]!;
    }

    final spaced = key.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match[1]} ${match[2]}',
    );

    return spaced
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  bool _isImageField(String key) {
    final normalized = key.toLowerCase();

    return normalized.contains('image') ||
        normalized.contains('imagen') ||
        normalized.contains('photo') ||
        normalized.contains('foto') ||
        normalized.contains('picture') ||
        normalized.contains('thumbnail') ||
        normalized.contains('avatar');
  }

  bool _isIgnoredField(String key) {
    final normalized = key.toLowerCase();

    return normalized == 'id' ||
        normalized.endsWith('_id') ||
        normalized.endsWith('id') ||
        normalized == 'pivot' ||
        normalized == 'created_at' ||
        normalized == 'updated_at' ||
        normalized == 'deleted_at' ||
        _isImageField(key);
  }

  String? _formatValue(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      final text = value.trim();

      if (text.isEmpty || text.toLowerCase() == 'null') {
        return null;
      }

      // No mostrar enlaces de imágenes.
      if (text.startsWith('http://') || text.startsWith('https://')) {
        return null;
      }

      return text;
    }

    if (value is Map) {
      const preferredKeys = ['name', 'nombre', 'description', 'descripcion'];

      final parts = <String>[];

      for (final key in preferredKeys) {
        final nestedValue = _formatValue(value[key]);

        if (nestedValue != null) {
          parts.add(nestedValue);
        }
      }

      if (parts.isEmpty) return null;

      return parts.join(' — ');
    }

    if (value is List) {
      final parts = value.map(_formatValue).whereType<String>().toList();

      if (parts.isEmpty) return null;

      return parts.join(', ');
    }

    if (value is num || value is bool) {
      return value.toString();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final firstName = _formatValue(president['name']);
    final lastName = _formatValue(
      president['lastName'] ?? president['last_name'],
    );

    final fullName = [firstName, lastName].whereType<String>().join(' ');

    final details = president.entries.where((entry) {
      if (_isIgnoredField(entry.key)) return false;

      // El nombre y apellido ya aparecen en el encabezado.
      if (['name', 'lastName', 'last_name'].contains(entry.key)) {
        return false;
      }

      return _formatValue(entry.value) != null;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del presidente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver a presidentes',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/presidentes');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Volver al menú principal',
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  fullName.isEmpty ? 'Nombre no disponible' : fullName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Información del presidente',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (details.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No hay más información disponible.'),
              ),
            ),
          ...details.map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(
                  _formatLabel(entry.key),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SelectableText(_formatValue(entry.value)!),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
