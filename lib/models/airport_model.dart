class Airport {
  final String code;
  final String name;
  final String city;

  Airport({required this.code, required this.name, required this.city});

  Map<String, String> toMap() {
    return {'code': code, 'name': name};
  }

  @override
  String toString() {
    return '$code - $name ($city)';
  }
}
