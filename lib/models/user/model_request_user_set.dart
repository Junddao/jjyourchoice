import 'dart:convert';

class ModelRequestUserSet {
  String? name;
  String? email;
  String? profileImage;
  String? gender;
  String? age;
  String? state;
  ModelRequestUserSet({
    this.name,
    this.email,
    this.profileImage,
    this.gender,
    this.age,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'gender': gender,
      'age': age,
      'state': state,
    };
  }

  factory ModelRequestUserSet.fromMap(Map<String, dynamic> map) {
    return ModelRequestUserSet(
      name: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
      gender: map['gender'],
      age: map['age'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestUserSet.fromJson(String source) =>
      ModelRequestUserSet.fromMap(json.decode(source));
}
