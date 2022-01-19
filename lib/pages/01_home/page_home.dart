import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/view_state.dart';
import 'package:jjyourchoice/models/coffee/model_request_get_coffee_list.dart';
import 'package:jjyourchoice/models/singleton_user.dart';
import 'package:jjyourchoice/pages/01_home/widgets/widget_list_Item.dart';
import 'package:jjyourchoice/pages/01_home/widgets/widget_top.dart';
import 'package:jjyourchoice/provider/parent_provider.dart';
import 'package:jjyourchoice/provider/provider_coffee.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
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
      ModelRequestGetCoffeeList modelRequestGetCoffeeList =
          ModelRequestGetCoffeeList(
        age: SingletonUser.singletonUser.userData.age,
        brand: "",
        gender: SingletonUser.singletonUser.userData.gender,
        preference: "like",
      );
      context.read<ProviderCoffee>().getCoffeeList(modelRequestGetCoffeeList);
    });
    super.initState();
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
            WidgetTop(),
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

  listWidget() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  print('item click');
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: buildBottomSheet,
                      backgroundColor: Colors.transparent);
                },
                child: WidgetListItem(index: index));
          },
        ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
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
            Image.asset(
              'assets/images/sample.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 18),
            Text('진짜 기본 카페라떼'),
            SizedBox(height: 18),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MColors.tomato,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Center(
                        child: Text('👍  추천', style: MTextStyles.bold16White)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MColors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Center(
                        child: Center(
                            child: Text('👎 비추천',
                                style: MTextStyles.bold16Black))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
