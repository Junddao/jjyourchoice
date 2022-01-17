import 'package:flutter/material.dart';
import 'package:jjyourchoice/pages/01_home/widgets/widget_list_Item.dart';
import 'package:jjyourchoice/pages/01_home/widgets/widget_top.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetTop(),
          Divider(),
          listWidget(),
        ],
      ),
    );
  }

  listWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return WidgetListItem(index: index);
          }),
    );
  }
}
