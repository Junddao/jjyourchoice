import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_request_model.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/pages/01_login/page_email_login_to_server.dart';
import 'package:jjyourchoice/pages/01_login/page_input_my_info.dart';
import 'package:jjyourchoice/pages/page_tab.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:provider/provider.dart';

class PageEmailLogin extends StatefulWidget {
  const PageEmailLogin({Key? key}) : super(key: key);

  @override
  State<PageEmailLogin> createState() => _PageEmailLoginState();
}

class _PageEmailLoginState extends State<PageEmailLogin> {
  bool? isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(providerConfigs: [
              EmailProviderConfiguration(),
            ]);
          }

          // Render your application if authenticated
          return PageEmailLoginToServer(user: snapshot.data!);
        });
  }

  goTabPage(BuildContext context, User user) async {
    setState(() {
      isLoading = true;
    });
    LoginService().signIn(user).catchError(_onErrorLogin).then((result) async {
      await context.read<ProviderUser>().getMe();

      if (SingletonUser.singletonUser.userData.age == '') {
        SingletonUser.singletonUser.userData.email = user.email ?? '';
        SingletonUser.singletonUser.userData.name = user.displayName ?? '';
        SingletonUser.singletonUser.userData.profileImage = user.photoURL ?? '';

        return PageInputMyInfo();
        // 정보 입력 안된 상태면 입력 창으로보내기
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('PageInputMyInfo', (route) => false);
      } else {
        return PageTab();
        // 입력 다 받아진 상태면
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('PageTab', (route) => false);
      }
      _stopLoading();

      // singleton에 넣고
      // shared에 넣고

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
}
