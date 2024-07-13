final class Beneficiary {
  final String id;
  final String name;
  final String phone;

  Beneficiary({
    required this.id,
    required this.name,
    required this.phone,
  });

  /// json
  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  /// json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
