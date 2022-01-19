import 'dart:convert';

class ModelRequestGetCoffeeList {
  String? age;
  String? gender;
  String? brand;
  String? preference;
  ModelRequestGetCoffeeList({
    this.age,
    this.gender,
    this.brand,
    this.preference,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'gender': gender,
      'brand': brand,
      'preference': preference,
    };
  }

  factory ModelRequestGetCoffeeList.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetCoffeeList(
      age: map['age'],
      gender: map['gender'],
      brand: map['brand'],
      preference: map['preference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetCoffeeList.fromJson(String source) =>
      ModelRequestGetCoffeeList.fromMap(json.decode(source));
}
