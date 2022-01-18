import 'dart:convert';

class SignInResponseModel {
  String? accessToken;
  int? userId;
  SignInResponseModel({
    this.accessToken,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
    };
  }

  factory SignInResponseModel.fromMap(Map<String, dynamic> map) {
    return SignInResponseModel(
      accessToken: map['accessToken'],
      userId: map['userId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponseModel.fromJson(String source) =>
      SignInResponseModel.fromMap(json.decode(source));
}
