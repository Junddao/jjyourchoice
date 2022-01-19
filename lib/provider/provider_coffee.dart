import 'package:flutter/widgets.dart';
import 'package:jjyourchoice/models/coffee/model_request_get_coffee_list.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_coffee_list.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/service/api_service.dart';

class ProviderCoffee extends ParentProvider {
  List<ModelResponseGetCoffeeListData>? modelResponseGetCoffeeListData;

  Future<void> getCoffeeList(
      ModelRequestGetCoffeeList modelRequestGetCoffeeList) async {
    try {
      setStateBusy();

      var api = ApiService();

      var response =
          await api.post('/coffee/list', modelRequestGetCoffeeList.toMap());
      ModelResponseGetCoffeeList modelResponseGetCoffeeList =
          ModelResponseGetCoffeeList.fromMap(response);

      modelResponseGetCoffeeListData = modelResponseGetCoffeeList.data!;

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }
}
