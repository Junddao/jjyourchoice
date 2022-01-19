import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_user_info.dart';
import 'package:jjyourchoice/pages/09_user_profile/widgets/choice_chip_widget.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:provider/provider.dart';

class PageUserProfile extends StatefulWidget {
  const PageUserProfile({Key? key}) : super(key: key);

  @override
  _PageUserProfileState createState() => _PageUserProfileState();
}

class _PageUserProfileState extends State<PageUserProfile> {
  EnumGender _gender = EnumGender.MAN;
  EnumAge _typeOfAge = EnumAge.ten;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('내정보'),
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () {
            // onSave();
          },
          child: Text(
            '저장하기',
            style: MTextStyles.bold14Tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topProfileWidget(),
          SizedBox(height: 24),
          Divider(
            thickness: 10,
          ),
          genderWidget(),
          Divider(
            thickness: 10,
          ),
          ageWidget(),
          Divider(
            thickness: 10,
          ),
          ListTile(
            title: Text("로그아웃", style: MTextStyles.regular16Tomato),
            onTap: logout,
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  topProfileWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/sample.png'),
          ),
          SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(SingletonUser.singletonUser.userData.email!,
                  style: MTextStyles.regular12Grey06),
              SizedBox(
                height: 20,
              ),
              Text('My Choice', style: MTextStyles.bold18Black),
              SizedBox(
                height: 8,
              ),
              RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(text: '스타벅스 ', style: MTextStyles.regular14Grey06),
                    TextSpan(
                        text: '카페라떼 (hot)', style: MTextStyles.regular14Grey06),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  genderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text('성별', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: MColors.tomato,
            title: Text('남자'),
            value: EnumGender.MAN,
            groupValue: _gender,
            onChanged: (EnumGender? value) {
              setState(() {
                _gender = value!;
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: MColors.tomato,
            title: Text('여자'),
            value: EnumGender.WOMEN,
            groupValue: _gender,
            onChanged: (EnumGender? value) {
              setState(() {
                _gender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  ageWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text('연령대', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 5.0, // gap between adjacent chips
            runSpacing: 5.0, // gap between lines

            children: [
              ChoiceChipWidget(
                returnDataFunc: returnDataFunc,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void returnDataFunc(EnumAge selectedData) {
    setState(() {
      _typeOfAge = selectedData;
    });
  }

  void onSave() async {
    if (1 == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("빈칸을 채워주세요."),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    try {} catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
      Navigator.of(context).pop();
    }
  }

  void logout() {
    LoginService().signOut().then((value) {
      if (value is String) {
        // fail
        print(value);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
      } else {
        // success

        ModelSharedPreferences.removeToken();

        SingletonUser.singletonUser.userData = ModelUserInfo();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageLogin', (route) => false);
      }
    });
  }
}
