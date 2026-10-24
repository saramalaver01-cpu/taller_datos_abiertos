import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegionDetailPage extends StatelessWidget {
  final Map<String, dynamic> region;

  const RegionDetailPage({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    final name = region['name']?.toString() ?? 'Región';

    final details = region.entries
        .where((entry) => entry.value != null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de región'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver a regiones',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/regiones');
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
              child: Column(
                children: [
                  const Icon(Icons.public, size: 64, color: Color(0xFF1565C0)),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Información de la región',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...details.map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: SelectableText(entry.value.toString()),
              ),
            );
          }),
        ],
      ),
    );
  }
}
