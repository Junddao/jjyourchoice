import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';
import 'package:jjyourchoice/pages/09_user_profile/widgets/choice_chip_widget.dart';
import 'package:jjyourchoice/pages/components/jj_button.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:provider/provider.dart';

class PageInputMyInfo extends StatefulWidget {
  const PageInputMyInfo({Key? key}) : super(key: key);

  @override
  _PageInputMyInfoState createState() => _PageInputMyInfoState();
}

class _PageInputMyInfoState extends State<PageInputMyInfo> {
  EnumGender _gender = EnumGender.MAN;
  EnumAge _typeOfAge = EnumAge.ten;

  @override
  void initState() {
    SingletonUser.singletonUser.userData.age = "10";
    SingletonUser.singletonUser.userData.gender = "male";
    SingletonUser.singletonUser.userData.state = "active";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomButton(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('간단 정보'),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ageWidget(),
        SizedBox(height: 24),
        genderWidget(),
      ],
    );
  }

  Widget _bottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: JJButton(
          text: '추천 커피 보러가요 😊',
          width: SizeConfig.screenWidth,
          press: goTabPage),
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
          Text('연령대 🙂', style: MTextStyles.bold18Black),
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
      switch (_typeOfAge) {
        case EnumAge.ten:
          SingletonUser.singletonUser.userData.age = "10";
          break;
        case EnumAge.twenty:
          SingletonUser.singletonUser.userData.age = "20";
          break;
        case EnumAge.thirty:
          SingletonUser.singletonUser.userData.age = "30";
          break;
        case EnumAge.fourty:
          SingletonUser.singletonUser.userData.age = "40";
          break;
        case EnumAge.fifty:
          SingletonUser.singletonUser.userData.age = "50";
          break;
        case EnumAge.overSixty:
          SingletonUser.singletonUser.userData.age = "60";
          break;
        default:
      }
    });
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
          Text('성별 😗', style: MTextStyles.bold18Black),
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
                SingletonUser.singletonUser.userData.gender = "male";
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
                SingletonUser.singletonUser.userData.gender = "female";
              });
            },
          ),
        ],
      ),
    );
  }

  goTabPage() async {
    ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet(
      age: SingletonUser.singletonUser.userData.age,
      email: SingletonUser.singletonUser.userData.email,
      gender: SingletonUser.singletonUser.userData.gender,
      name: SingletonUser.singletonUser.userData.name,
      profileImage: SingletonUser.singletonUser.userData.profileImage,
      state: SingletonUser.singletonUser.userData.state,
    );
    try {
      await context.read<ProviderUser>().setUser(modelRequestUserSet);
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
