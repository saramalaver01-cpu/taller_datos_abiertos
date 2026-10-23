import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'views/tourism_page.dart';
import 'views/presidents_page.dart';
import 'views/home_page.dart';
import 'views/departments_page.dart';
import 'views/regions_page.dart';
import 'views/department_detail_page.dart';
import 'models/department.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(const ColombiaApp());
}

class ColombiaApp extends StatelessWidget {
  const ColombiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Datos Abiertos de Colombia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/departamentos',
      builder: (context, state) => const DepartmentsPage(),
    ),
    GoRoute(
      path: '/regiones',
      builder: (context, state) => const RegionsPage(),
    ),
    GoRoute(
      path: '/presidentes',
      builder: (context, state) => const PresidentsPage(),
    ),
    GoRoute(path: '/turismo', builder: (context, state) => const TourismPage()),
    GoRoute(
      path: '/departamentos/:id',
      builder: (context, state) {
        final department = state.extra as Department;

        return DepartmentDetailPage(department: department);
      },
    ),
  ],
);

class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
      body: const Center(
        child: Text(
          '¡Bienvenido a Colombia!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
