import 'package:flutter/material.dart';

import '../services/api_service.dart';

import 'package:go_router/go_router.dart';

class RegionsPage extends StatefulWidget {
  const RegionsPage({super.key});

  @override
  State<RegionsPage> createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  final ApiService _apiService = ApiService();

  late Future<List<Map<String, dynamic>>> _regionsFuture;

  @override
  void initState() {
    super.initState();
    _regionsFuture = _apiService.getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regiones'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Volver al menú',
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _regionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    const Text('No se pudieron cargar las regiones.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _regionsFuture = _apiService.getRegions();
                        });
                      },
                      child: const Text('Intentar de nuevo'),
                    ),
                  ],
                ),
              ),
            );
          }

          final regions = snapshot.data ?? [];

          if (regions.isEmpty) {
            return const Center(child: Text('No hay regiones disponibles.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: regions.length,
            itemBuilder: (context, index) {
              final region = regions[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.public)),
                  title: Text(
                    region['name']?.toString() ?? 'Sin nombre',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    region['description']?.toString() ?? 'Sin descripción',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
