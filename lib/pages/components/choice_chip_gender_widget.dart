import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/gender.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/provider.dart';

class ChoiceChipGenderWidget extends StatefulWidget {
  const ChoiceChipGenderWidget({
    Key? key,
    required this.initGender,
  }) : super(key: key);

  final EnumGender initGender;

  @override
  _ChoiceChipGenderWidgetState createState() =>
      new _ChoiceChipGenderWidgetState();
}

class _ChoiceChipGenderWidgetState extends State<ChoiceChipGenderWidget> {
  List<EnumGender> enumGenders = List.generate(
      EnumGender.values.length, (index) => EnumGender.values[index]);
  EnumGender? selectedChoice;

  @override
  void initState() {
    selectedChoice = widget.initGender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    enumGenders.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(TransFormat.getKRStringFromEnumGender(item)),
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
            context.read<ProviderUser>().setSelectedGender(item);
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }
}
