import 'package:flutter/widgets.dart';
import 'package:jjyourchoice/models/coffee/model_brand.dart';
import 'package:jjyourchoice/models/coffee/model_request_get_coffee_list.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_brand.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_coffee_list.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/service/api_service.dart';

class ProviderCoffee extends ParentProvider {
  List<ModelResponseGetCoffeeListData>? modelResponseGetCoffeeListData;
  ModelRequestGetCoffeeList filteredValue = ModelRequestGetCoffeeList();
  List<ModelBrand>? brands = [];

  Future<void> getCoffeeList() async {
    try {
      setStateBusy();

      var api = ApiService();

      var response = await api.post('/coffee/list', filteredValue.toMap());
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

  Future<bool> setLikeCoffee(int id) async {
    try {
      setStateBusy();

      var api = ApiService();

      var response = await api.get('/coffee/like/$id');
      setStateIdle();
      if (response['result'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }

  Future<void> setHateCoffee(int id) async {
    try {
      setStateBusy();

      var api = ApiService();

      var response = await api.get('/coffee/hate/$id');

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }

  Future<bool> getCoffeeBrand() async {
    try {
      setStateBusy();

      var api = ApiService();

      var response = await api.get('/coffee/brand');
      brands = ModelResponseGetBrand.fromMap(response).data;

      setStateIdle();
      return true;
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }
}
