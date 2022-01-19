import 'package:flutter/material.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';

class WidgetTop extends StatelessWidget {
  const WidgetTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MColors.tomato,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('필터선택', style: MTextStyles.regular14White),
                Icon(Icons.arrow_drop_down, color: MColors.white),
              ],
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: [
              Chip(
                backgroundColor: MColors.tomato_10,
                label: Text('남자', style: MTextStyles.bold12Tomato),
                onDeleted: () {
                  print('aaa');
                },
                deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
              ),
              Chip(
                backgroundColor: MColors.tomato_10,
                label: Text('30대', style: MTextStyles.bold12Tomato),
                onDeleted: () {},
                deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
              ),
              Chip(
                backgroundColor: MColors.tomato_10,
                label: Text('스타벅스', style: MTextStyles.bold12Tomato),
                onDeleted: () {},
                deleteIcon: Icon(Icons.cancel, color: MColors.tomato),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
