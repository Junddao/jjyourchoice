import 'dart:convert';

import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';

import 'package:jjyourchoice/models/user/model_response_user_get.dart';
import 'package:jjyourchoice/models/user/model_user_info.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/utils/trans_format.dart';

class ProviderUser extends ParentProvider {
  ModelUserInfo selectedUser = ModelUserInfo();
  EnumAge selectedAge = EnumAge.none;
  EnumGender selectedGender = EnumGender.none;
  EnumBrand selectedBrand = EnumBrand.none;

  void setSelectedAge(EnumAge value) {
    selectedAge = value;
    notifyListeners();
  }

  void setSelectedGender(EnumGender value) {
    selectedGender = value;
    notifyListeners();
  }

  void setSelectedBrand(EnumBrand value) {
    selectedBrand = value;
    notifyListeners();
  }

  Future<void> getMe() async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.get('/user/get/me');
      ModelResponseUserGet modelResponseUserGet =
          ModelResponseUserGet.fromMap(response);
      ModelUserInfo modelResponseUserGetData = modelResponseUserGet.data!;

      // user factory 에 정보 때려박기

      SingletonUser.singletonUser.setUser(modelResponseUserGetData);

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }

  Future<void> getUser(int id) async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.get('/user/get/$id');
      ModelResponseUserGet modelResponseUserGet =
          ModelResponseUserGet.fromMap(response);
      ModelUserInfo modelResponseUserGetData = modelResponseUserGet.data!;

      selectedUser = ModelUserInfo.fromMap(modelResponseUserGetData.toMap());

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }

  Future<void> setUser(ModelRequestUserSet modelRequestUserSet) async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.post('/user/set', modelRequestUserSet.toMap());

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }
}
