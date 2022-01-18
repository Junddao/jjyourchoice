import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jjyourchoice/pages/00_etc/page_block.dart';
import 'package:jjyourchoice/pages/00_intro/page_intro_slide.dart';
import 'package:jjyourchoice/pages/01_home/page_home.dart';
import 'package:jjyourchoice/pages/01_login/page_input_my_info.dart';
import 'package:jjyourchoice/pages/01_login/page_login.dart';
import 'package:jjyourchoice/pages/09_user_profile/page_user_profile.dart';
import 'package:jjyourchoice/pages/page_tab.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      case 'PageHome':
        return CupertinoPageRoute(
          builder: (_) => PageHome(),
          settings: settings,
        );

      case 'PageTab':
        return CupertinoPageRoute(
          builder: (_) => PageTab(),
          settings: settings,
        );

      case 'PageUserProfile':
        return CupertinoPageRoute(
          builder: (_) => PageUserProfile(),
          settings: settings,
        );

      case 'PageIntroSlide':
        return CupertinoPageRoute(
          builder: (_) => PageIntroSlide(),
          settings: settings,
        );

      case 'PageBlock':
        return CupertinoPageRoute(
          builder: (_) => PageBlock(),
          settings: settings,
        );

      case 'PageLogin':
        return CupertinoPageRoute(
          builder: (_) => PageLogin(),
          settings: settings,
        );

      case 'PageInputMyInfo':
        return CupertinoPageRoute(
          builder: (_) => PageInputMyInfo(),
          settings: settings,
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
            ),
          ),
        );
    }
  }
}
