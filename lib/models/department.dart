class Department {
  final int id;
  final String name;
  final String description;
  final int municipalities;
  final int population;
  final String capital;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.municipalities,
    required this.population,
    required this.capital,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      municipalities: json['municipalities'] ?? 0,
      population: json['population'] ?? 0,
      capital: json['cityCapital']?['name'] ?? 'Sin capital',
    );
  }
}
