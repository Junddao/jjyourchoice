import 'package:jjyourchoice/models/user/model_user_info.dart';

class SingletonUser {
  static final singletonUser = SingletonUser();

  ModelUserInfo userData = ModelUserInfo();

  Future<void> setUser(ModelUserInfo userData) async {
    SingletonUser.singletonUser.userData = userData;
  }
}
