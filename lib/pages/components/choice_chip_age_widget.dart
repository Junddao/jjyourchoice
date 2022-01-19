import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/src/provider.dart';

class ChoiceChipAgeWidget extends StatefulWidget {
  const ChoiceChipAgeWidget({
    Key? key,
    required this.initAge,
  }) : super(key: key);

  final EnumAge initAge;

  @override
  _ChoiceChipAgeWidgetState createState() => new _ChoiceChipAgeWidgetState();
}

class _ChoiceChipAgeWidgetState extends State<ChoiceChipAgeWidget> {
  List<EnumAge> enumAges =
      List.generate(EnumAge.values.length, (index) => EnumAge.values[index]);
  late EnumAge selectedChoice;

  @override
  void initState() {
    selectedChoice = widget.initAge;
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
    enumAges.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(TransFormat.getKRStringFromEnumAge(item)),
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
            context.read<ProviderUser>().setSelectedAge(item);
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
