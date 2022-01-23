import 'dart:convert';

class ModelBrand {
  int? id;
  String? name;
  String? logo;
  ModelBrand({
    this.id,
    this.name,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }

  factory ModelBrand.fromMap(Map<String, dynamic> map) {
    return ModelBrand(
      id: map['id']?.toInt(),
      name: map['name'],
      logo: map['logo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelBrand.fromJson(String source) =>
      ModelBrand.fromMap(json.decode(source));
}
