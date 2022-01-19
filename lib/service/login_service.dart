import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jjyourchoice/models/model_config.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:jjyourchoice/models/sign_in/sige_in_response_model.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_model.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:jjyourchoice/service/api_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return authResult.user;
    } catch (error) {
      print('error');
      throw Exception();
    }
  }

  Future<SignInResponseModel?> signInWithKakao(String token) async {
    final Map<String, dynamic> data = await LoginService().kakaoLogin(token);

    String customToken = data['customToken'] ?? '';
    String email = data['email'] ?? '';

    fb.UserCredential? result = await _auth.signInWithCustomToken(customToken);

    fb.User? firebaseUser = result.user;
    SignInResponseModel signInResponseModel = await signIn(firebaseUser);

    return signInResponseModel;

    // aws server에 token 요청
  }

  Future<SignInResponseModel> signIn(fb.User? firebaseUser) async {
    // String idToken = await firebaseUser!.getIdToken();
    SignInRequestModel signInRequestModel =
        await LoginService().getSignInRequest(firebaseUser);

    var api = ApiService();
    // Map<String, dynamic> map = {
    //   'firebaseIdToken': idToken,
    //   'osType' : osType,
    //   'osVersion': osVersion,
    //   'deviceModel': deviceModel,
    // };

    Map<String, dynamic> _data =
        await api.post('/user/signin', signInRequestModel.toMap());
    SignInResponseModel signInResponseModel =
        SignInResponseModel.fromMap(_data['data']);
    ModelSharedPreferences.writeToken(signInResponseModel.accessToken!);

    return signInResponseModel;
  }

  Future<Map<String, dynamic>> kakaoLogin(String token) async {
    final String _path = "/user/verification";
    final map = {
      "type": "kakao",
      "token": token,
    };
    final _headers = {"Content-Type": "application/json"};

    var _data = jsonEncode(map);

    print('${ModelConfig().serverBaseUrl}');
    var response = await Dio()
        .post(
          '${ModelConfig().serverBaseUrl}$_path',
          data: _data,
          options: Options(
            headers: _headers,
          ),
        )
        .timeout(Duration(seconds: 10));

    print('Api get : url $_path  done.');
    print('dio response = ${response.toString()}');
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      print('error : ${response.statusCode} failed to login with token');
      print(response.data);
      throw Exception("${response.statusCode} failed to login with token");
    }
    //
  }

  Future<SignInRequestModel> getSignInRequest(firebaseUser) async {
    SignInRequestModel signInRequestModel = SignInRequestModel();
    var deviceInfo = DeviceInfoPlugin();

    String? firebaseIdToken = await firebaseUser!.getIdToken();
    String? deviceModel = '';
    String? osType = '';
    String? osVersion = '';

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;

      deviceModel = androidInfo.model;
      osType = 'Android';
      osVersion = "Android $release (SDK $sdkInt)";
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      var version = iosInfo.systemVersion;
      var machine = iosInfo.utsname.machine;

      deviceModel = machine;
      osType = 'IOS';
      osVersion = version;
    }

    signInRequestModel.firebaseIdToken = firebaseIdToken;
    signInRequestModel.deviceModel = deviceModel;
    signInRequestModel.osType = osType;
    signInRequestModel.osVersion = osVersion;
    signInRequestModel.uid = ApiService.deviceIdentifier;

    return signInRequestModel;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return '로그아웃 실패. 다시 시도해주세요.';
    }
  }
}
