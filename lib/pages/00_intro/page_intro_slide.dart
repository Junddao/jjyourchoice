import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:jjyourchoice/style/constants.dart';

class PageIntroSlide extends StatefulWidget {
  const PageIntroSlide({Key? key}) : super(key: key);

  @override
  _PageIntroSlideState createState() => _PageIntroSlideState();
}

class _PageIntroSlideState extends State<PageIntroSlide> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "최고의 커피를 확인하세요.",
        description: "모두가 선택한 최고의 브랜드, 커피를 확인하세요.",
        pathImage: "assets/images/coffee1.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "당신의 의견을 알려주세요.",
        description: "내가 선택한 최고의 브랜드, 커피를 알려주세요.",
        pathImage: "assets/images/coffee2.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "이제 시작하세요.",
        description: "재밌게 즐기시면 됩니다.",
        pathImage: "assets/images/coffee3.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    print("End of slides");
    Navigator.of(context).pushNamed('PageLogin');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
