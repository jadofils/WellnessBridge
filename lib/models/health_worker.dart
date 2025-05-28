class HealthWorker {
  final int? hwID;
  final String name;
  final String gender;
  final String? dob;
  final String role;
  final String? telephone;
  final String email;
  final String? password;
  final String? image;
  final String? address;
  final int? cadID;
  final String? createdAt;
  final String? updatedAt;

  HealthWorker({
    this.hwID,
    required this.name,
    required this.gender,
    this.dob,
    required this.role,
    this.telephone,
    required this.email,
    this.password,
    this.image,
    this.address,
    this.cadID,
    this.createdAt,
    this.updatedAt,
  });

  factory HealthWorker.fromJson(Map<String, dynamic> json) {
    return HealthWorker(
      hwID: json['hwID'],
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'],
      role: json['role'],
      telephone: json['telephone'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      address: json['address'],
      cadID: json['cadID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'dob': dob,
      'role': role,
      'telephone': telephone,
      'email': email,
      'password': password,
      'image': image,
      'address': address,
      'cadID': cadID,
    };
  }
}
