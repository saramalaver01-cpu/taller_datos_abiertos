import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'models/department.dart';

import 'views/home_page.dart';
import 'views/departments_page.dart';
import 'views/department_detail_page.dart';
import 'views/regions_page.dart';
import 'views/region_detail_page.dart';
import 'views/presidents_page.dart';
import 'views/tourism_page.dart';
import 'views/president_detail_page.dart';
import 'views/tourism_detail_page.dart';

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
    // Menú principal
    GoRoute(path: '/', builder: (context, state) => const HomePage()),

    // Lista de departamentos
    GoRoute(
      path: '/departamentos',
      builder: (context, state) => const DepartmentsPage(),
    ),

    // Detalle de departamento
    GoRoute(
      path: '/departamentos/:id',
      builder: (context, state) {
        final department = state.extra as Department;

        return DepartmentDetailPage(department: department);
      },
    ),

    // Lista de regiones
    GoRoute(
      path: '/regiones',
      builder: (context, state) => const RegionsPage(),
    ),

    // Detalle de región
    GoRoute(
      path: '/regiones/:id',
      builder: (context, state) {
        final region = state.extra as Map<String, dynamic>;

        return RegionDetailPage(region: region);
      },
    ),

    // Lista de presidentes
    GoRoute(
      path: '/presidentes',
      builder: (context, state) => const PresidentsPage(),
    ),

    // Lista de atractivos turísticos
    GoRoute(path: '/turismo', builder: (context, state) => const TourismPage()),
    GoRoute(
      path: '/presidentes/:id',
      builder: (context, state) {
        final president = state.extra as Map<String, dynamic>;

        return PresidentDetailPage(president: president);
      },
    ),
    GoRoute(
      path: '/turismo/:id',
      builder: (context, state) {
        final attraction = state.extra as Map<String, dynamic>;

        return TourismDetailPage(attraction: attraction);
      },
    ),
  ],
);
