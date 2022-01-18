import 'package:flutter/material.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';
import 'package:jjyourchoice/pages/components/jj_button.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:provider/provider.dart';

class PageInputMyInfo extends StatefulWidget {
  const PageInputMyInfo({Key? key}) : super(key: key);

  @override
  _PageInputMyInfoState createState() => _PageInputMyInfoState();
}

class _PageInputMyInfoState extends State<PageInputMyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomSheet: _bottomButton(),
    );
  }

  Widget _body() {
    SingletonUser.singletonUser.userData.gender = "male";
    SingletonUser.singletonUser.userData.age = "10";
    SingletonUser.singletonUser.userData.state = "active";
    return Column(
      children: [
        Text('my info'),
      ],
    );
  }

  Widget _bottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: JJButton(
          text: '대화방 보기', width: SizeConfig.screenWidth, press: goTabPage),
    );
  }

  goTabPage() {
    ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet(
      age: SingletonUser.singletonUser.userData.age,
      email: SingletonUser.singletonUser.userData.email,
      gender: SingletonUser.singletonUser.userData.gender,
      name: SingletonUser.singletonUser.userData.name,
      profileImage: SingletonUser.singletonUser.userData.profileImage,
      state: SingletonUser.singletonUser.userData.state,
    );
    try {
      context.read<ProviderUser>().setUser(modelRequestUserSet);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageTab', (route) => false);
    } catch (e) {
      _onError(e);
    }
  }

  _onError(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('유저정보 생성에 실패했습니다. 다시 시도해주세요.'),
    ));
  }
}
