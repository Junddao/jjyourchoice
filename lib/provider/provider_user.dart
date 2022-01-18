import 'dart:convert';

import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';

import 'package:jjyourchoice/models/user/model_response_user_get.dart';
import 'package:jjyourchoice/models/user/model_response_user_set_report.dart';
import 'package:jjyourchoice/models/user/model_user_info.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/service/api_service.dart';

class ProviderUser extends ParentProvider {
  ModelUserInfo? selectedUser = ModelUserInfo();

  Future<void> getMe() async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.get('/user/get/me');
      ModelResponseUserGet modelResponseUserGet =
          ModelResponseUserGet.fromMap(response);
      ModelResponseUserGetData modelResponseUserGetData =
          modelResponseUserGet.data!;

      // user factory 에 정보 때려박기
      ModelUserInfo modelUserInfo =
          ModelUserInfo.fromMap(modelResponseUserGetData.toMap());
      SingletonUser.singletonUser.setUser(modelUserInfo);

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
      ModelResponseUserGetData modelResponseUserGetData =
          modelResponseUserGet.data!;

      // user factory 에 정보 때려박기
      selectedUser = ModelUserInfo.fromMap(modelResponseUserGetData.toMap());
      // SingletonUser.singletonUser.setUser(modelUserInfo);

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

      // user factory 에 정보 때려박기
      ModelUserInfo modelUserInfo =
          ModelUserInfo.fromMap(modelRequestUserSet.toMap());
      modelUserInfo.id = SingletonUser.singletonUser.userData.id;
      SingletonUser.singletonUser.setUser(modelUserInfo);

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }

  Future<bool> getUserReport(int userId) async {
    try {
      setStateBusy();
      var api = ApiService();

      var map = {
        'userId': userId,
      };

      var response = await api.post('/user/get/report', map);
      ModelResponseUserSetReport ResponseUserSetReport =
          ModelResponseUserSetReport.fromMap(response);
      UserReport userReport = ResponseUserSetReport.data!;

      // user factory 에 정보 때려박기

      setStateIdle();

      return userReport.reported!;
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }

  Future<void> setUserReport(int userId) async {
    try {
      setStateBusy();
      var api = ApiService();

      var map = {
        'userId': userId,
      };

      var response = await api.post('/user/set/report', map);

      // user factory 에 정보 때려박기

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }
}
