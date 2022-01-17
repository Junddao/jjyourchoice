import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/textstyles.dart';

class ChoiceChipWidget extends StatefulWidget {
  const ChoiceChipWidget({
    Key? key,
    required this.returnDataFunc,
  }) : super(key: key);

  final Function returnDataFunc;

  @override
  _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  List<EnumAge> enumAges =
      List.generate(EnumAge.values.length, (index) => EnumAge.values[index]);
  late EnumAge selectedChoice;

  _buildChoiceList() {
    List<Widget> choices = [];
    enumAges.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(getLabelTypeOfMusicList(item)),
          labelStyle: selectedChoice != item
              ? MTextStyles.bold14Black
              : MTextStyles.bold14White,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: MColors.tomato,
          selected: selectedChoice == item,
          onSelected: (selected) {
            widget.returnDataFunc(item);
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  void initState() {
    selectedChoice = EnumAge.ten;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  String getLabelTypeOfMusicList(EnumAge value) {
    String returnString;
    switch (value) {
      case EnumAge.ten:
        returnString = '10대';
        break;
      case EnumAge.twenty:
        returnString = '20대';
        break;
      case EnumAge.thirty:
        returnString = '30대';
        break;
      case EnumAge.fourty:
        returnString = '40대';
        break;
      case EnumAge.fifty:
        returnString = '50대';
        break;
      case EnumAge.overSixty:
        returnString = '60대 이상';
        break;
    }
    return returnString;
  }
}
