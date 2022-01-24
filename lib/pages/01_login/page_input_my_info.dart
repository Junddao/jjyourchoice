import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';
import 'package:jjyourchoice/pages/components/choice_chip_age_widget.dart';
import 'package:jjyourchoice/pages/components/choice_chip_gender_widget.dart';
import 'package:jjyourchoice/pages/components/jj_button.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/provider.dart';

class PageInputMyInfo extends StatefulWidget {
  const PageInputMyInfo({Key? key}) : super(key: key);

  @override
  _PageInputMyInfoState createState() => _PageInputMyInfoState();
}

class _PageInputMyInfoState extends State<PageInputMyInfo> {
  EnumGender _gender = EnumGender.none;
  EnumAge _age = EnumAge.none;

  @override
  void initState() {
    SingletonUser.singletonUser.userData.age = "";
    SingletonUser.singletonUser.userData.gender = "";
    SingletonUser.singletonUser.userData.state = "active";
    Future.microtask(() {
      context.read<ProviderUser>().setSelectedAge(EnumAge.none);
      context.read<ProviderUser>().setSelectedBrand(EnumBrand.none);
      context.read<ProviderUser>().setSelectedGender(EnumGender.none);
    });
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
              ChoiceChipAgeWidget(
                initAge: _age,
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
          Text('성별 😗', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 5.0, // gap between adjacent chips
            runSpacing: 5.0, // gap between lines

            children: [
              ChoiceChipGenderWidget(
                initGender: _gender,
              ),
            ],
          ),
        ],
      ),
    );
  }
  

  // genderWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //         vertical: kDefaultVerticalPadding,
  //         horizontal: kDefaultHorizontalPadding),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 12),
  //         Text('성별 😗', style: MTextStyles.bold18Black),
  //         SizedBox(height: 8),
  //         RadioListTile(
  //           contentPadding: EdgeInsets.zero,
  //           activeColor: MColors.tomato,
  //           title: Text('남자'),
  //           value: EnumGender.male,
  //           groupValue: _gender,
  //           onChanged: (EnumGender? value) {
  //             setState(() {
  //               _gender = value!;
  //               SingletonUser.singletonUser.userData.gender = "male";
  //             });
  //           },
  //         ),
  //         RadioListTile(
  //           contentPadding: EdgeInsets.zero,
  //           activeColor: MColors.tomato,
  //           title: Text('여자'),
  //           value: EnumGender.female,
  //           groupValue: _gender,
  //           onChanged: (EnumGender? value) {
  //             setState(() {
  //               _gender = value!;
  //               SingletonUser.singletonUser.userData.gender = "female";
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  goTabPage() async {
    SingletonUser.singletonUser.userData.age =
        TransFormat.getENStringFromEnumAge(
            context.read<ProviderUser>().selectedAge);
    SingletonUser.singletonUser.userData.gender =
        TransFormat.getENStringFromEnumGender(
            context.read<ProviderUser>().selectedGender);
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
