import 'dart:convert';

class ModelUserInfo {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? gender;
  String? age;
  String? state;

  ModelUserInfo({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.gender,
    this.age,
    this.state = "active",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'gender': gender,
      'age': age,
      'state': state,
    };
  }

  factory ModelUserInfo.fromMap(Map<String, dynamic> map) {
    return ModelUserInfo(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
      gender: map['gender'],
      age: map['age'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUserInfo.fromJson(String source) =>
      ModelUserInfo.fromMap(json.decode(source));
}
