class Cadre {
  final int? cadID;
  final String name;
  final String description;
  final String qualification;
  final String? createdAt;
  final String? updatedAt;

  Cadre({
    this.cadID,
    required this.name,
    required this.description,
    required this.qualification,
    this.createdAt,
    this.updatedAt,
  });

  factory Cadre.fromJson(Map<String, dynamic> json) {
    return Cadre(
      cadID: json['cadID'],
      name: json['name'],
      description: json['description'],
      qualification: json['qualification'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'qualification': qualification,
    };
  }
}
