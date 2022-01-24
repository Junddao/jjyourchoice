import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';

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
        styleTitle: MTextStyles.bold26black,
        styleDescription: MTextStyles.regular18black,
        title: "오늘의 커피를 확인하세요.",
        description: "추천 커피를 확인해 보세요.",
        pathImage: "assets/images/hot.png",
        backgroundColor: MColors.white,
      ),
    );
    slides.add(
      new Slide(
        styleTitle: MTextStyles.bold26black,
        styleDescription: MTextStyles.regular18black,
        title: "당신의 의견을 알려주세요.",
        description: "내가 좋아하는 커피에 투표하세요.",
        pathImage: "assets/images/ice.png",
        backgroundColor: MColors.white,
      ),
    );
    slides.add(
      new Slide(
        styleTitle: MTextStyles.bold26black,
        styleDescription: MTextStyles.regular18black,
        title: "이제 시작하세요.",
        description: "재밌게 즐기세요 .",
        pathImage: "assets/images/ade.png",
        backgroundColor: MColors.white,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    print("End of slides");
    Navigator.of(context).pushNamed('PageLogin');
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.black,
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.black,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.black,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33ffcc5c)),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new IntroSlider(
      slides: this.slides,
      renderSkipBtn: this.renderSkipBtn(),
      // skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      // nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      // doneButtonStyle: myButtonStyle(),
    );
  }
}
