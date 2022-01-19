import 'package:flutter/material.dart';
import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:jjyourchoice/utils/trans_format.dart';
import 'package:provider/src/provider.dart';

class ChoiceChipBrandWidget extends StatefulWidget {
  const ChoiceChipBrandWidget({
    Key? key,
    required this.initBrand,
  }) : super(key: key);

  final EnumBrand initBrand;

  @override
  _ChoiceChipBrandWidgetState createState() =>
      new _ChoiceChipBrandWidgetState();
}

class _ChoiceChipBrandWidgetState extends State<ChoiceChipBrandWidget> {
  List<EnumBrand> enumBrands = List.generate(
      EnumBrand.values.length, (index) => EnumBrand.values[index]);
  late EnumBrand selectedChoice;

  @override
  void initState() {
    selectedChoice = widget.initBrand;
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
    enumBrands.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(TransFormat.getKRStringFromEnumBrand(item)),
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
            context.read<ProviderUser>().setSelectedBrand(item);
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
