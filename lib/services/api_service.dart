import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/department.dart';

class ApiService {
  final String baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';

  Future<List<Map<String, dynamic>>> getRegions() async {
    final url = Uri.parse('$baseUrl/Region');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al consultar regiones: ${response.statusCode}');
    }

    final dynamic decodedData = jsonDecode(response.body);

    final List<dynamic> data;

    if (decodedData is List) {
      data = decodedData;
    } else if (decodedData is Map && decodedData['value'] is List) {
      data = decodedData['value'];
    } else {
      throw Exception('Formato de regiones no válido.');
    }

    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  Future<List<Map<String, dynamic>>> getPresidents() async {
    final url = Uri.parse('$baseUrl/President');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al consultar presidentes: ${response.statusCode}');
    }

    final dynamic decodedData = jsonDecode(response.body);
    final List<dynamic> data;

    if (decodedData is List) {
      data = decodedData;
    } else if (decodedData is Map && decodedData['value'] is List) {
      data = decodedData['value'];
    } else {
      throw Exception('Formato de presidentes no válido.');
    }

    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  Future<List<Map<String, dynamic>>> getTouristicAttractions() async {
    final url = Uri.parse('$baseUrl/TouristicAttraction');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al consultar atractivos turísticos: ${response.statusCode}',
      );
    }

    final dynamic decodedData = jsonDecode(response.body);
    final List<dynamic> data;

    if (decodedData is List) {
      data = decodedData;
    } else if (decodedData is Map && decodedData['value'] is List) {
      data = decodedData['value'];
    } else {
      throw Exception('Formato de atractivos turísticos no válido.');
    }

    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  Future<List<Department>> getDepartments() async {
    final url = Uri.parse('$baseUrl/Department');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al consultar la API: ${response.statusCode}');
    }

    final dynamic decodedData = jsonDecode(response.body);
    final List<dynamic> data;

    if (decodedData is List) {
      data = decodedData;
    } else if (decodedData is Map && decodedData['value'] is List) {
      data = decodedData['value'];
    } else {
      throw Exception('Formato de respuesta no válido.');
    }

    return data
        .map((item) => Department.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
