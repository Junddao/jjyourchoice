import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/models/user/model_request_user_set.dart';
import 'package:jjyourchoice/models/user/model_user_info.dart';
import 'package:jjyourchoice/pages/components/choice_chip_age_widget.dart';
import 'package:jjyourchoice/pages/components/choice_chip_gender_widget.dart';
import 'package:jjyourchoice/pages/components/jj_dialog.dart';
import 'package:jjyourchoice/provider/provider_tab.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/provider.dart';

class PageUserProfile extends StatefulWidget {
  const PageUserProfile({Key? key}) : super(key: key);

  @override
  _PageUserProfileState createState() => _PageUserProfileState();
}

class _PageUserProfileState extends State<PageUserProfile> {
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
            onSave();
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
          SingletonUser.singletonUser.userData.profileImage == '' ||
                  SingletonUser.singletonUser.userData.profileImage == null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/sample.png'),
                  backgroundColor: MColors.tomato,
                )
              : CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(
                      SingletonUser.singletonUser.userData.profileImage!),
                ),
          SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(SingletonUser.singletonUser.userData.name ?? '',
                  style: MTextStyles.bold18Black),
              SizedBox(
                height: 20,
              ),
              Text(SingletonUser.singletonUser.userData.email ?? '',
                  style: MTextStyles.regular14BlackColor)
              // SizedBox(
              //   height: 20,
              // ),
              // Text('My Choice', style: MTextStyles.bold18Black),
              // SizedBox(
              //   height: 8,
              // ),
              // RichText(
              //   overflow: TextOverflow.ellipsis,
              //   text: TextSpan(
              //     children: [
              //       TextSpan(text: '스타벅스 ', style: MTextStyles.regular14Grey06),
              //       TextSpan(
              //           text: '카페라떼 (hot)', style: MTextStyles.regular14Grey06),
              //     ],
              //   ),
              // ),
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
                initGender: TransFormat.getEnumGenderFromString(
                    SingletonUser.singletonUser.userData.gender!),
              ),
            ],
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
          Text('연령대 😊', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 5.0, // gap between adjacent chips
            runSpacing: 5.0, // gap between lines

            children: [
              ChoiceChipAgeWidget(
                initAge: TransFormat.getEnumAgeFromString(
                    SingletonUser.singletonUser.userData.age!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSave() async {
    try {
      bool result = await JJDialog.showTwoButtonDialog(
          context: context, title: '저장하기', subTitle: '정말 저장하시겠습니까?');
      if (result == false) {
        return;
      } else {
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
        context.read<ProviderUser>().setUser(modelRequestUserSet);

        Provider.of<ProviderTab>(context, listen: false).selectedIndex = 0;
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('저장에 실패하였습니다. 다시 시도해주세요.')));
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
