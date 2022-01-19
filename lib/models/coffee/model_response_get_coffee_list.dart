import 'dart:convert';

import 'package:jjyourchoice/models/coffee/model_coffee.dart';

class ModelResponseGetCoffeeList {
  String? result;
  String? message;
  List<ModelResponseGetCoffeeListData>? data;
  ModelResponseGetCoffeeList({
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

  factory ModelResponseGetCoffeeList.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetCoffeeList(
      result: map['result'],
      message: map['message'],
      data: map['data'] != null
          ? List<ModelResponseGetCoffeeListData>.from(map['data']
              ?.map((x) => ModelResponseGetCoffeeListData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetCoffeeList.fromJson(String source) =>
      ModelResponseGetCoffeeList.fromMap(json.decode(source));
}

class ModelResponseGetCoffeeListData {
  ModelCoffee? coffee;
  int? preferenceCount;
  ModelResponseGetCoffeeListData({
    this.coffee,
    this.preferenceCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'coffee': coffee?.toMap(),
      'preferenceCount': preferenceCount,
    };
  }

  factory ModelResponseGetCoffeeListData.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetCoffeeListData(
      coffee: map['coffee'] != null ? ModelCoffee.fromMap(map['coffee']) : null,
      preferenceCount: map['preferenceCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetCoffeeListData.fromJson(String source) =>
      ModelResponseGetCoffeeListData.fromMap(json.decode(source));
}
