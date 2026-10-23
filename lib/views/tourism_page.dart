import 'package:flutter/material.dart';

import '../services/api_service.dart';

import 'package:go_router/go_router.dart';

class TourismPage extends StatefulWidget {
  const TourismPage({super.key});

  @override
  State<TourismPage> createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  final ApiService _apiService = ApiService();

  late Future<List<Map<String, dynamic>>> _attractionsFuture;

  @override
  void initState() {
    super.initState();
    _attractionsFuture = _apiService.getTouristicAttractions();
  }

  void _retry() {
    setState(() {
      _attractionsFuture = _apiService.getTouristicAttractions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atractivos turísticos'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Volver al menú',
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _attractionsFuture,
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
                    const Text(
                      'No se pudieron cargar los atractivos turísticos.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Intentar de nuevo'),
                    ),
                  ],
                ),
              ),
            );
          }

          final attractions = snapshot.data ?? [];

          if (attractions.isEmpty) {
            return const Center(
              child: Text('No hay atractivos turísticos disponibles.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: attractions.length,
            itemBuilder: (context, index) {
              final attraction = attractions[index];

              final name =
                  attraction['name']?.toString() ?? 'Nombre no disponible';

              final description =
                  attraction['description']?.toString() ??
                  'Descripción no disponible';

              final cityData = attraction['city'];
              final city = cityData is Map
                  ? cityData['name']?.toString() ?? ''
                  : '';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.travel_explore),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${city.isEmpty ? "Ciudad no disponible" : city}\n'
                      '$description',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
