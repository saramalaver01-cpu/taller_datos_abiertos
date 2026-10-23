import 'package:flutter/material.dart';

import '../models/department.dart';
import '../services/api_service.dart';

import 'package:go_router/go_router.dart';

class DepartmentsPage extends StatefulWidget {
  const DepartmentsPage({super.key});

  @override
  State<DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  final ApiService _apiService = ApiService();

  late Future<List<Department>> _departmentsFuture;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  void _loadDepartments() {
    _departmentsFuture = _apiService.getDepartments();
  }

  void _retry() {
    setState(() {
      _loadDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Volver al menú',
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: FutureBuilder<List<Department>>(
        future: _departmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando departamentos...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No se pudieron cargar los departamentos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Intentar de nuevo'),
                    ),
                  ],
                ),
              ),
            );
          }

          final departments = snapshot.data ?? [];

          if (departments.isEmpty) {
            return const Center(
              child: Text('No hay departamentos disponibles.'),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.public,
                      size: 36,
                      color: Color(0xFF1565C0),
                    ),
                    title: const Text('Datos de Colombia'),
                    subtitle: Text(
                      '${departments.length} departamentos encontrados',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    final department = departments[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        onTap: () {
                          context.push(
                            '/departamentos/${department.id}',
                            extra: department,
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF1565C0)
                              .withValues(alpha: 0.1),
                          child: Text(
                            '${department.id}',
                            style: const TextStyle(
                              color: Color(0xFF1565C0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          department.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Capital: ${department.capital}\n'
                          'Municipios: ${department.municipalities}',
                        ),
                        isThreeLine: true,
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
