import 'package:flutter/material.dart';

import '../models/department.dart';

class DepartmentDetailPage extends StatelessWidget {
  final Department department;

  const DepartmentDetailPage({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(department.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                child: Text(
                  department.name.isNotEmpty
                      ? department.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                department.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Información general',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.location_city,
              title: 'Capital',
              value: department.capital,
            ),
            _infoCard(
              icon: Icons.map,
              title: 'Municipios',
              value: department.municipalities.toString(),
            ),
            _infoCard(
              icon: Icons.people,
              title: 'Población',
              value: department.population.toString(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              department.description.isEmpty
                  ? 'No hay descripción disponible.'
                  : department.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
