import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TourismDetailPage extends StatelessWidget {
  final Map<String, dynamic> attraction;

  const TourismDetailPage({super.key, required this.attraction});

  String _formatLabel(String key) {
    const labels = {
      'name': 'Nombre',
      'description': 'Descripción',
      'city': 'Ciudad',
      'department': 'Departamento',
      'address': 'Dirección',
      'location': 'Ubicación',
      'type': 'Tipo de atractivo',
      'category': 'Categoría',
      'openingHours': 'Horario',
      'opening_hours': 'Horario',
      'price': 'Precio',
      'website': 'Sitio web',
      'phone': 'Teléfono',
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
        normalized.contains('thumbnail');
  }

  bool _isIgnoredField(String key) {
    final normalized = key.toLowerCase();

    return normalized == 'id' ||
        normalized.endsWith('_id') ||
        normalized.endsWith('id') ||
        normalized == 'created_at' ||
        normalized == 'updated_at' ||
        normalized == 'deleted_at' ||
        normalized == 'pivot' ||
        _isImageField(key);
  }

  String? _formatValue(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      final text = value.trim();

      if (text.isEmpty || text.toLowerCase() == 'null') {
        return null;
      }

      return text;
    }

    if (value is num || value is bool) {
      return value.toString();
    }

    if (value is Map) {
      // Para ciudad, departamento u otros objetos relacionados,
      // mostrar nombres y descripciones, no el JSON completo.
      const preferredKeys = [
        'name',
        'nombre',
        'description',
        'descripcion',
        'address',
        'direccion',
        'type',
        'category',
      ];

      final parts = <String>[];

      for (final key in preferredKeys) {
        final nestedValue = value[key];

        if (nestedValue != null &&
            nestedValue.toString().trim().isNotEmpty &&
            nestedValue.toString().toLowerCase() != 'null') {
          parts.add(nestedValue.toString().trim());
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

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final name = _formatValue(attraction['name']) ?? 'Atractivo turístico';

    final details = attraction.entries.where((entry) {
      if (_isIgnoredField(entry.key)) return false;
      if (entry.key == 'name') return false;

      return _formatValue(entry.value) != null;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del atractivo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver a atractivos turísticos',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/turismo');
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
                  name,
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
            'Información del atractivo turístico',
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
            final value = _formatValue(entry.value)!;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(
                  _formatLabel(entry.key),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SelectableText(value),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
