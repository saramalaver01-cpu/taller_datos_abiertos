import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explora Colombia 🇨🇴',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consulta información de nuestro país '
              'a través de datos abiertos.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Categorías disponibles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Departamentos',
              description: 'Conoce sus capitales y municipios.',
              icon: Icons.map_outlined,
              onTap: () => context.go('/departamentos'),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Regiones',
              description: 'Explora las regiones de Colombia.',
              icon: Icons.public,
              onTap: () => context.go('/regiones'),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Presidentes',
              description: 'Consulta información presidencial.',
              icon: Icons.account_balance,
              onTap: () => context.go('/presidentes'),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Atractivos turísticos',
              description: 'Descubre lugares para visitar.',
              icon: Icons.landscape_outlined,
              onTap: () => context.go('/turismo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF1565C0).withValues(alpha: 0.12),
          child: Icon(icon, color: const Color(0xFF1565C0)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(description),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
