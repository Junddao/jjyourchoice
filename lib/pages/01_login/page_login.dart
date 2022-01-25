import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:jjyourchoice/models/sign_in/sige_in_response_model.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_request_model.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';

import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/util.dart';

import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:logger/logger.dart';

import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MColors.white,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: isLoading == true
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text('오늘의 커피', style: MTextStyles.bold26black),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildKakaoLogin(),
                      Platform.isIOS
                          ? SizedBox(height: 20.0)
                          : SizedBox.shrink(),
                      Platform.isIOS ? _buildAppleLogin() : SizedBox.shrink(),
                      SizedBox(height: 20),
                      _buildEmailLogin(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _buildKakaoLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _loginWithKakao(),
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Image.asset(
              "assets/images/ic_logo_kakao.png",
              width: 24,
              height: 24,
            ),
            Spacer(),
            Text('카카오로 로그인', style: MTextStyles.regular18black),
            Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _loginWithKakao() async {
    setState(() {
      isLoading = true;
    });
    try {
      final isKakaoInstalled = await isKakaoTalkInstalled();

      var code = isKakaoInstalled
          ? await AuthCodeClient.instance.requestWithTalk()
          // ? await kakao.AuthCodeClient.instance.request()
          : await AuthCodeClient.instance.request();
      print(code);
      await _issueAccessToken(code);
    } catch (e) {
      logger.e(e.toString());
      _stopLoading();
    }
  }

  _issueAccessToken(String authCode) async {
    Logger().v("authCode : $authCode");
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      var tokenManager = DefaultTokenManager();
      await tokenManager.setToken(token);

      logger.v(token.toJson());
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => Home()
      //     ));
      var user = await UserApi.instance.me();
      var email = user.kakaoAccount!.email!;
      var nickName = user.kakaoAccount!.profile!.nickname;
      var profileImageUrl = user.kakaoAccount!.profile!.profileImageUrl;
      if (user.kakaoAccount == null) {
        logger.v(user.kakaoAccount!.email);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text('이메일이 없습니다.'),
        )));
        _stopLoading();
        return;
      }
      logger.v(user.toJson());
      final String accessToken = token.toJson()["access_token"].toString();
      // logger.v("kakao token: ${accessToken}");
      _createKakaoAccountRequest(
          accessToken, email, nickName!, profileImageUrl!);
    } catch (e) {
      logger.v(e.toString());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        content: Text('${e.toString()}'),
      )));
      _stopLoading();
    }
  }

  void _createKakaoAccountRequest(
      String token, String email, String nickName, String profileImage) async {
    LoginService()
        .signInWithKakao(token)
        .catchError(_onErrorLogin)
        .then((result) async {
      // server에  getuser 해서 가져오고
      await context.read<ProviderUser>().getMe();

      SingletonUser.singletonUser.userData.email = email;
      SingletonUser.singletonUser.userData.name = nickName;
      SingletonUser.singletonUser.userData.profileImage = profileImage;

      if (SingletonUser.singletonUser.userData.age == '') {
        // 정보 입력 안된 상태면 입력 창으로보내기
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageInputMyInfo', (route) => false);
      } else {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('PageInputMyInfo', (route) => false);
        // 입력 다 받아진 상태면
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageTab', (route) => false);
      }

      // singleton에 넣고
      // shared에 넣고

      _stopLoading();

      // 페이지 전환
    });
  }

  _stopLoading() {
    if (isLoading == true) {
      setState(() {
        isLoading = false;
      });
    }
  }

  _onErrorLogin(Object error) {
    _stopLoading();
    print('kakao login error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$error'),
    ));
  }

  _buildAppleLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _loginWithApple(),
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Icon(
              FontAwesomeIcons.apple,
              size: 24,
              color: MColors.white,
            ),
            Spacer(),
            Text('Apple로 로그인', style: MTextStyles.regular18white),
            Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _loginWithApple() async {
    fb.User? user = await LoginService().signInWithApple();
    // String firebaseIdToken = await user!.getIdToken();
    // SignInRequestModel signInRequestModel = SignInRequestModel(
    //   firebaseIdToken: firebaseIdToken,
    //   deviceModel: ApiService.deviceModel,
    //   osType: ApiService.osType,
    //   osVersion: ApiService.osVersion,
    //   uid: ApiService.deviceIdentifier,
    // );

    LoginService().signIn(user).catchError(_onErrorLogin).then((result) async {
      await context.read<ProviderUser>().getMe();

      if (SingletonUser.singletonUser.userData.age == '') {
        SingletonUser.singletonUser.userData.email = user!.email ?? '';
        SingletonUser.singletonUser.userData.name = user.displayName ?? '';
        SingletonUser.singletonUser.userData.profileImage = user.photoURL ?? '';
        // 정보 입력 안된 상태면 입력 창으로보내기
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageInputMyInfo', (route) => false);
      } else {
        // 입력 다 받아진 상태면
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageTab', (route) => false);
      }

      // singleton에 넣고
      // shared에 넣고

      _stopLoading();

      // 페이지 전환
    });
  }

  _buildEmailLogin() {
    return Container(
      width: double.infinity,
      child: Center(
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('PageEmailLogin');
            },
            child: Text('이메일로 로그인', style: MTextStyles.bold12White)),
      ),
    );
  }
}
