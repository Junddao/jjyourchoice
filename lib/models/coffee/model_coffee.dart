import 'dart:convert';

class ModelCoffee {
  int? id;
  String? brand;
  String? name;
  String? temp;
  String? image;
  int? totalLikeCount;
  int? totalHateCount;
  ModelCoffee({
    this.id,
    this.brand,
    this.name,
    this.temp,
    this.image,
    this.totalLikeCount,
    this.totalHateCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'temp': temp,
      'image': image,
      'totalLikeCount': totalLikeCount,
      'totalHateCount': totalHateCount,
    };
  }

  factory ModelCoffee.fromMap(Map<String, dynamic> map) {
    return ModelCoffee(
      id: map['id']?.toInt(),
      brand: map['brand'],
      name: map['name'],
      temp: map['temp'],
      image: map['image'],
      totalLikeCount: map['totalLikeCount']?.toInt(),
      totalHateCount: map['totalHateCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelCoffee.fromJson(String source) =>
      ModelCoffee.fromMap(json.decode(source));
}
