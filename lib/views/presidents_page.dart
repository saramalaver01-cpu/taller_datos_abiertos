import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/api_service.dart';

class PresidentsPage extends StatefulWidget {
  const PresidentsPage({super.key});

  @override
  State<PresidentsPage> createState() => _PresidentsPageState();
}

class _PresidentsPageState extends State<PresidentsPage> {
  final ApiService _apiService = ApiService();

  late Future<List<Map<String, dynamic>>> _presidentsFuture;

  @override
  void initState() {
    super.initState();
    _presidentsFuture = _apiService.getPresidents();
  }

  void _retry() {
    setState(() {
      _presidentsFuture = _apiService.getPresidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presidentes'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Volver al menú principal',
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _presidentsFuture,
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
                      'No se pudieron cargar los presidentes.',
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

          final presidents = snapshot.data ?? [];

          if (presidents.isEmpty) {
            return const Center(child: Text('No hay presidentes disponibles.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: presidents.length,
            itemBuilder: (context, index) {
              final president = presidents[index];

              final name = [president['name'], president['lastName']]
                  .where(
                    (part) => part != null && part.toString().trim().isNotEmpty,
                  )
                  .join(' ');

              final start = president['startPeriodDate']?.toString() ?? '';
              final end = president['endPeriodDate']?.toString() ?? '';
              final party = president['politicalParty']?.toString() ?? '';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.account_balance),
                  ),
                  title: Text(
                    name.isEmpty ? 'Nombre no disponible' : name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Periodo: ${start.isEmpty ? "No disponible" : start}'
                      ' - ${end.isEmpty ? "No disponible" : end}\n'
                      'Partido: ${party.isEmpty ? "No disponible" : party}',
                    ),
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    final presidentId = president['id']?.toString() ?? '$index';

                    context.push('/presidentes/$presidentId', extra: president);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
