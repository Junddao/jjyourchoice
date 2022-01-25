import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:provider/src/provider.dart';

class PageEmailLoginToServer extends StatefulWidget {
  const PageEmailLoginToServer({Key? key, required this.user})
      : super(key: key);
  final User user;
  @override
  _PageEmailLoginToServerState createState() => _PageEmailLoginToServerState();
}

class _PageEmailLoginToServerState extends State<PageEmailLoginToServer> {
  bool? isLoading = false;

  @override
  void initState() {
    Future.microtask(() {
      goTabPage(widget.user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container();
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

  goTabPage(User user) async {
    LoginService().signIn(user).catchError(_onErrorLogin).then((result) async {
      await context.read<ProviderUser>().getMe();

      if (SingletonUser.singletonUser.userData.age == '') {
        SingletonUser.singletonUser.userData.email = user.email ?? '';
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
      _stopLoading();

      // singleton에 넣고
      // shared에 넣고

      // 페이지 전환
    });
  }
}
