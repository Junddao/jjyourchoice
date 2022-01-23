import 'dart:convert';

import 'package:jjyourchoice/models/coffee/model_brand.dart';

class ModelResponseGetBrand {
  String? result;
  String? message;
  List<ModelBrand>? data;
  ModelResponseGetBrand({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetBrand.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetBrand(
      result: map['result'],
      message: map['message'],
      data: map['data'] != null
          ? List<ModelBrand>.from(
              map['data']?.map((x) => ModelBrand.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetBrand.fromJson(String source) =>
      ModelResponseGetBrand.fromMap(json.decode(source));
}
