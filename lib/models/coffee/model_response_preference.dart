import 'dart:convert';

class ModelRequestPreference {
  String? result;
  String? message;
  ModelPreference? data;
  ModelRequestPreference({
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

  factory ModelRequestPreference.fromMap(Map<String, dynamic> map) {
    return ModelRequestPreference(
      result: map['result'],
      message: map['message'],
      data: map['data'] != null ? ModelPreference.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestPreference.fromJson(String source) =>
      ModelRequestPreference.fromMap(json.decode(source));
}

class ModelPreference {
  bool? liked;
  bool? hated;
  ModelPreference({
    this.liked = false,
    this.hated = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'liked': liked,
      'hated': hated,
    };
  }

  factory ModelPreference.fromMap(Map<String, dynamic> map) {
    return ModelPreference(
      liked: map['liked'],
      hated: map['hated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelPreference.fromJson(String source) =>
      ModelPreference.fromMap(json.decode(source));
}
