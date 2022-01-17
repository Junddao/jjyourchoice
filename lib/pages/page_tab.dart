import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:jjyourchoice/pages/01_home/page_home.dart';
import 'package:jjyourchoice/pages/09_user_profile/page_user_profile.dart';
import 'package:jjyourchoice/provider/provider_tab.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';

import 'package:provider/provider.dart';

class PageTab extends StatefulWidget {
  @override
  _PageTabState createState() => _PageTabState();
}

class _PageTabState extends State<PageTab> {
  final List<Widget> _tabs = [
    PageHome(),
    PageUserProfile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        setState(() {
          print("You can not get out of here! kkk");
        });
        return Future(() => false);
      },
      child: Consumer<ProviderTab>(
        builder: (context, value, child) => Scaffold(
          body: _tabs[Provider.of<ProviderTab>(context).selectedIndex],
          bottomNavigationBar: new BottomNavigationBar(
            selectedItemColor: MColors.tomato,
            onTap: _onItemTapped,
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            currentIndex: value.selectedIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                label: '홈',
              ), //
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.queue_music_outlined,
              //     size: 20,
              //   ),
              //   label: '게시판',
              // ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: '프로필',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    Provider.of<ProviderTab>(context, listen: false).selectedIndex = index;
  }
}
