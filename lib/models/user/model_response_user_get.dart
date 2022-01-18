import 'dart:convert';

import 'package:jjyourchoice/models/user/model_user_info.dart';

class ModelResponseUserGet {
  String? result;
  String? message;
  ModelUserInfo? data;
  ModelResponseUserGet({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ModelResponseUserGet.fromMap(Map<String, dynamic> map) {
    return ModelResponseUserGet(
      result: map['result'],
      message: map['message'],
      data: map['data'] != null ? ModelUserInfo.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUserGet.fromJson(String source) =>
      ModelResponseUserGet.fromMap(json.decode(source));
}
