import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/enum/view_state.dart';
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
  @override
  void initState() {
    ParentProvider().initailize();

    Future.microtask(() {
      getUserInfo();
      getCoffeeList();
      context.read<ProviderCoffee>().getCoffeeList();
    });
    super.initState();
  }

  void getUserInfo() {
    context.read<ProviderUser>().setSelectedAge(
        TransFormat.getEnumAgeFromString(
            SingletonUser.singletonUser.userData.age!));
    context.read<ProviderUser>().setSelectedGender(
        TransFormat.getEnumGenderFromString(
            SingletonUser.singletonUser.userData.gender!));
    context
        .read<ProviderUser>()
        .setSelectedBrand(TransFormat.getEnumBrandFromString(''));
  }

  void getCoffeeList() {
    context.read<ProviderCoffee>().filteredValue = ModelRequestGetCoffeeList(
      age: TransFormat.getENStringFromEnumAge(
          context.read<ProviderUser>().selectedAge),
      brand: TransFormat.getENStringFromEnumBrand(
          context.read<ProviderUser>().selectedBrand),
      gender: TransFormat.getENStringFromEnumGender(
          context.read<ProviderUser>().selectedGender),
      preference: "like",
    );
    context.read<ProviderCoffee>().getCoffeeList();
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
        return Consumer(builder: (__, ProviderUser pUser, ___) {
          if (pUser.state == ViewState.Busy) {
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
        });
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
                          context
                              .read<ProviderUser>()
                              .setSelectedGender(EnumGender.none);
                          getCoffeeList();
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
                        onDeleted: () {
                          context
                              .read<ProviderUser>()
                              .setSelectedAge(EnumAge.none);
                          getCoffeeList();
                        },
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
                      onDeleted: () {
                        context
                            .read<ProviderUser>()
                            .setSelectedBrand(EnumBrand.none);
                        getCoffeeList();
                      },
                      deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  listWidget() {
    List<ModelResponseGetCoffeeListData>? coffeeLists =
        context.read<ProviderCoffee>().modelResponseGetCoffeeListData!;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: coffeeLists.isEmpty
            ? Center(child: Text('해당 조건에 맞는 커피가 없어요 😭'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: coffeeLists.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        await context
                            .read<ProviderCoffee>()
                            .checkPreference(coffeeLists[index].coffee!.id!);
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
    ProviderCoffee providerCoffee = context.read<ProviderCoffee>();
    List<ModelResponseGetCoffeeListData>? coffeeList =
        providerCoffee.modelResponseGetCoffeeListData;
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
            Stack(
              children: [
                coffeeList![index].coffee!.temp == 'hot'
                    ? Image.asset(
                        'assets/images/hot.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/images/ice.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                Positioned(
                  child: CachedNetworkImage(
                    imageUrl: getBrandLogo(
                        providerCoffee, coffeeList[index].coffee!.brand!),
                    height: 40,
                    width: 40,
                  ),
                )
              ],
            ),
            SizedBox(height: 18),
            coffeeList[index].coffee!.temp == 'hot'
                ? Text('#${coffeeList[index].coffee!.brand!}',
                    style: MTextStyles.bold14Tomato)
                : Text('#${coffeeList[index].coffee!.brand!}',
                    style: MTextStyles.bold14Blue),
            coffeeList[index].coffee!.temp == 'hot'
                ? Text(
                    'Hot',
                    style: MTextStyles.bold14Tomato,
                  )
                : Text(
                    'Iced',
                    style: MTextStyles.bold14Blue,
                  ),
            SizedBox(height: 18),
            Text(coffeeList[index].coffee!.name!,
                style: MTextStyles.regular14BlackColor),
            SizedBox(height: 18),
            Divider(),
            context.read<ProviderCoffee>().modelPreference!.liked == true ||
                    context.read<ProviderCoffee>().modelPreference!.liked ==
                        true
                ? Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            '이미 투표하신 커피입니다. 😙',
                            style: MTextStyles.bold16Tomato,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
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
                                      subTitle: '이미 추천 하신 커피입니다. 😉')
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Center(
                                child: Text('👍  추천',
                                    style: MTextStyles.bold16White)),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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

  getBrandLogo(ProviderCoffee providerCoffee, String? brand) {
    String? brandImage;
    providerCoffee.brands!.forEach((element) {
      if (element.name == brand) {
        brandImage = element.logo;
      }
    });
    return brandImage!;
  }
}
