import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:jjyourchoice/models/sign_in/sign_in_model.dart';
import 'package:jjyourchoice/provider/provider_auth.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/util.dart';

import 'package:kakao_flutter_sdk/auth.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              // child: DefaultTextStyle(
              //   style: MTextStyles.bold40black,
              //   child: AnimatedTextKit(

              //     animatedTexts: [
              //       WavyAnimatedText('DongNe'),
              //       WavyAnimatedText('SoSik'),
              //       WavyAnimatedText('동네소식'),
              //     ],
              //     isRepeatingAnimation: true,
              //   ),
              // ),

              child: Text('오늘의 커피', style: MTextStyles.bold26black),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildKakaoLogin(),
                SizedBox(height: 20.0),
                // Platform.isIOS
                //     ? InkWell(
                //         onTap: () async {
                //           User? user = await ProviderAuth().signInWithApple();
                //           String firebaseIdToken = await user!.getIdToken();
                //           ModelReqeustUserConnect modelReqeustUserConnect =
                //               ModelReqeustUserConnect(
                //             firebaseIdToken: firebaseIdToken,
                //             deviceModel: ApiService.deviceModel,
                //             osType: ApiService.osType,
                //             osVersion: ApiService.osVersion,
                //             uid: ApiService.deviceIdentifier,
                //           );
                //           await context
                //               .read<ProviderUser>()
                //               .userConnect(modelReqeustUserConnect)
                //               .catchError((onError) {
                //             context
                //                 .read<ProviderUser>()
                //                 .userSignIn(modelReqeustUserConnect);
                //           });

                //           ModelRequestUserSet modelRequestUserSet =
                //               ModelRequestUserSet.fromMap(SingletonUser
                //                   .singletonUser.userData
                //                   .toUserSetMap());

                //           modelRequestUserSet.email = user.email ?? '';
                //           modelRequestUserSet.name = user.displayName ?? '이름없음';
                //           modelRequestUserSet.phoneNumber =
                //               user.phoneNumber ?? '';
                //           modelRequestUserSet.profileImage =
                //               user.photoURL ?? '';
                //           await context
                //               .read<ProviderUser>()
                //               .setUser(modelRequestUserSet);

                //           await context.read<ProviderUser>().getMe();

                //           double? myLat =
                //               await ModelSharedPreferences.readMyLat();
                //           double? myLng =
                //               await ModelSharedPreferences.readMyLng();

                //           if (myLat == 0 && myLng == 0) {
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                //                 'PageSetLocation', (route) => false);
                //           } else {
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                //                 'PageMap', (route) => false);
                //           }
                //         },
                //         child: Stack(
                //           children: [
                //             Container(
                //               height: 48,
                //               width: SizeConfig.screenWidth * 0.8,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(30.0),
                //                   color: MColors.black),
                //               child: Center(
                //                   child: Text('Apple로 로그인',
                //                       style: MTextStyles.bold16White)),
                //             ),
                //             Positioned(
                //               top: 12,
                //               left: 12,
                //               child: Icon(
                //                 FontAwesomeIcons.apple,
                //                 size: 24,
                //                 color: MColors.white,
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     : SizedBox.shrink(),
                SizedBox(height: 40.0),
                InkWell(
                  onTap: () async {},
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        width: SizeConfig.screenWidth * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: MColors.warm_grey),
                        child: Center(
                            child: Text('Guest로 사용하기',
                                style: MTextStyles.bold16White)),
                      ),
                    ],
                  ),
                ),
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
              "assets/icons/ic_logo_kakao.png",
              width: 24,
              height: 24,
            ),
            Spacer(),
            Text('카카오로 로그인', style: MTextStyles.regular18Black54),
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
      _createKakaoAccountRequest(accessToken, email);
    } catch (e) {
      logger.v(e.toString());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        content: Text('${e.toString()}'),
      )));
      _stopLoading();
    }
  }

  void _createKakaoAccountRequest(String token, String email) async {
    context
        .read<ProviderAuth>()
        .signInWithKakao(token)
        .catchError(_onErrorLogin)
        .then((result) async {
      if (result!.email == '') {
        fb.User? fbUser = fb.FirebaseAuth.instance.currentUser;

        // user객체에 넣어주기

      } else {
        // server에  getuser 해서 가져오고
        // singleton에 넣고
        // shared에 넣고
      }
      _stopLoading();

      // 페이지 전환
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageTab', (route) => false);
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
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('$error'),
    // ));
  }
}
