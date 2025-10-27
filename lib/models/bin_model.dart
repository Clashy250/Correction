class Bin {
  final String id;
  final String name;
  final String location;
  final double fillLevel;
  final String status;
  final DateTime lastUpdated;

  Bin({
    required this.id,
    required this.name,
    required this.location,
    required this.fillLevel,
    required this.status,
    required this.lastUpdated,
  });

  factory Bin.fromJson(Map<String, dynamic> json) {
    return Bin(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      location: json['location'],
      fillLevel: (json['fillLevel'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'unknown',
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
