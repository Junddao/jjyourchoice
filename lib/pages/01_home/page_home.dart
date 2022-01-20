import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/models/coffee/model_request_get_coffee_list.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_coffee_list.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/pages/01_home/widgets/widget_list_Item.dart';
import 'package:jjyourchoice/pages/components/choice_chip_age_widget.dart';
import 'package:jjyourchoice/pages/components/choice_chip_brand_widget.dart';
import 'package:jjyourchoice/pages/components/choice_chip_gender_widget.dart';
import 'package:jjyourchoice/pages/components/jj_button.dart';
import 'package:jjyourchoice/pages/components/jj_dialog.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/provider/provider_coffee.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  EnumGender _gender = EnumGender.none;
  EnumAge _age = EnumAge.none;
  EnumBrand _brand = EnumBrand.none;

  @override
  void initState() {
    ParentProvider().initailize();

    getUserInfo();

    Future.microtask(() {
      context.read<ProviderCoffee>().filteredValue = ModelRequestGetCoffeeList(
        age: SingletonUser.singletonUser.userData.age,
        brand: "",
        gender: SingletonUser.singletonUser.userData.gender,
        preference: "like",
      );
      context.read<ProviderCoffee>().getCoffeeList();
    });
    super.initState();
  }

  void getUserInfo() {
    SingletonUser.singletonUser.userData.gender == 'male'
        ? _gender = EnumGender.male
        : _gender = EnumGender.female;

    switch (SingletonUser.singletonUser.userData.age) {
      case "10":
        _age = EnumAge.ten;
        break;
      case "20":
        _age = EnumAge.twenty;
        break;
      case "30":
        _age = EnumAge.thirty;
        break;
      case "40":
        _age = EnumAge.fourty;
        break;
      case "50":
        _age = EnumAge.fifty;
        break;
      case "60":
        _age = EnumAge.overSixty;
        break;
      default:
    }

    switch (SingletonUser.singletonUser.userData.age) {
      case "10":
        _age = EnumAge.ten;
        break;
      case "20":
        _age = EnumAge.twenty;
        break;
      case "30":
        _age = EnumAge.thirty;
        break;
      case "40":
        _age = EnumAge.fourty;
        break;
      case "50":
        _age = EnumAge.fifty;
        break;
      case "60":
        _age = EnumAge.overSixty;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('순위'),
      automaticallyImplyLeading: false,
    );
  }

  Widget body() {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          print("You can not get out of here! kkk");
        });
        return Future(() => false);
      },
      child: Consumer(builder: (_, ProviderCoffee value, child) {
        if (value.modelResponseGetCoffeeListData == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topWidget(),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultHorizontalPadding, vertical: 8),
              child: Text('내가 좋아하는 커피를 눌러서 추천할 수 있어요! 😚',
                  overflow: TextOverflow.ellipsis,
                  style: MTextStyles.regular12Grey06),
            ),
            Divider(),
            listWidget(),
          ],
        );
      }),
    );
  }

  topWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await showFilterDialog();
              context.read<ProviderCoffee>().filteredValue =
                  ModelRequestGetCoffeeList(
                age: TransFormat.getENStringFromEnumAge(
                    context.read<ProviderUser>().selectedAge),
                brand: TransFormat.getENStringFromEnumBrand(
                    context.read<ProviderUser>().selectedBrand),
                gender: TransFormat.getENStringFromEnumGender(
                    context.read<ProviderUser>().selectedGender),
                preference: "like",
              );
              context.read<ProviderCoffee>().getCoffeeList();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MColors.tomato,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('필터선택', style: MTextStyles.regular14White),
                  Icon(Icons.arrow_drop_down, color: MColors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            // spacing: 10,
            children: [
              context.read<ProviderUser>().selectedGender == EnumGender.none
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Chip(
                        backgroundColor: MColors.tomato_10,
                        label: Text(
                            TransFormat.getKRStringFromEnumGender(
                                context.watch<ProviderUser>().selectedGender),
                            style: MTextStyles.bold12Tomato),
                        onDeleted: () {
                          print('aaa');
                        },
                        deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
                      ),
                    ),
              context.read<ProviderUser>().selectedAge == EnumAge.none
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Chip(
                        backgroundColor: MColors.tomato_10,
                        label: Text(
                            TransFormat.getKRStringFromEnumAge(
                                context.watch<ProviderUser>().selectedAge),
                            style: MTextStyles.bold12Tomato),
                        onDeleted: () {},
                        deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
                      ),
                    ),
              context.read<ProviderUser>().selectedBrand == EnumBrand.none
                  ? SizedBox.shrink()
                  : Chip(
                      backgroundColor: MColors.tomato_10,
                      label: Text(
                          TransFormat.getKRStringFromEnumBrand(
                              context.watch<ProviderUser>().selectedBrand),
                          style: MTextStyles.bold12Tomato),
                      onDeleted: () {},
                      deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  listWidget() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: context
                .read<ProviderCoffee>()
                .modelResponseGetCoffeeListData!
                .isEmpty
            ? Center(child: Text('해당 조건에 맞는 커피가 없어요 😭'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        print('item click');
                        showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return buildBottomSheet(context, index);
                                },
                                backgroundColor: Colors.transparent)
                            .then((value) {
                          context.read<ProviderCoffee>().getCoffeeList();
                        });
                      },
                      child: WidgetListItem(index: index));
                },
              ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context, int index) {
    List<ModelResponseGetCoffeeListData>? coffeeList =
        context.read<ProviderCoffee>().modelResponseGetCoffeeListData;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: coffeeList![index].coffee!.image!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 18),
            Text(coffeeList[index].coffee!.brand!,
                style: MTextStyles.regular14BlackColor),
            SizedBox(height: 18),
            Text(coffeeList[index].coffee!.name!,
                style: MTextStyles.regular14BlackColor),
            SizedBox(height: 18),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      int id = coffeeList[index].coffee!.id!;
                      bool result = await context
                          .read<ProviderCoffee>()
                          .setLikeCoffee(id)
                          .catchError((onError) {
                        print('error park');
                        return false;
                      });

                      if (result == true) {
                        JJDialog.showOneButtonDialog(
                                context: context,
                                title: '추천 완료',
                                subTitle: '추천해 주셔서 감사합니다. 😉')
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        JJDialog.showOneButtonDialog(
                                context: context,
                                title: '중복 추천 안되요.',
                                subTitle: '추천은 하루 한번만 가능합니다. 😉')
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MColors.tomato,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Center(
                          child:
                              Text('👍  추천', style: MTextStyles.bold16White)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      int id = coffeeList[index].coffee!.id!;
                      context.read<ProviderCoffee>().setHateCoffee(id);

                      JJDialog.showOneButtonDialog(
                              context: context,
                              title: '비추천 완료',
                              subTitle: '소중한 한표 감사합니다. 😌')
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MColors.white,
                        border: Border.all(),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Center(
                          child: Center(
                              child: Text('👎 비추천',
                                  style: MTextStyles.bold16Black))),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showFilterDialog() async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0)), //this right here

          child: Container(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          genderWidget(),
                          ageWidget(),
                          brandWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: JJButton(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              text: '확인',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              press: () {
                                Navigator.of(context).pop(true);
                              })),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
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
            spacing: 10.0, // gap between adjacent chips
            runSpacing: 10.0, // gap between lines

            children: [
              ChoiceChipAgeWidget(
                initAge: context.read<ProviderUser>().selectedAge,
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
          Text('성별 🙂', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 10.0, // gap between adjacent chips
            runSpacing: 10.0, // gap between lines

            children: [
              ChoiceChipGenderWidget(
                initGender: context.read<ProviderUser>().selectedGender,
              ),
            ],
          ),
        ],
      ),
    );
  }

  brandWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text('브랜드 🏘', style: MTextStyles.bold18Black),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 10.0, // gap between adjacent chips
            runSpacing: 10.0, // gap between lines

            children: [
              ChoiceChipBrandWidget(
                initBrand: context.read<ProviderUser>().selectedBrand,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
