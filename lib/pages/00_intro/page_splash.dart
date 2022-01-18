import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jjyourchoice/enum/user_state.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:provider/provider.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    Future.microtask(() async {
      String? myToken = await ModelSharedPreferences.readToken();

      if (myToken == '') {
        // 로그인으로 보내기
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageIntroSlide', (route) => false);
      } else {
        await context.read<ProviderUser>().getMe().catchError((onError) async {
          // 로그인으로 보내기
        });
        if (SingletonUser.singletonUser.userData.state ==
            describeEnum(UserState.block)) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageBlock', (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageTab', (route) => false);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '오늘의 커피',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
