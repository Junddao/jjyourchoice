import 'package:flutter/material.dart';
import 'package:jjyourchoice/style/textstyles.dart';

class WidgetListItem extends StatelessWidget {
  const WidgetListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Column(
            children: [
              Text('${index + 1}위', style: MTextStyles.bold18Black),
              Text('▲ ${2}', style: MTextStyles.bold10Tomato),
              // Row(▲▼
              //   children: [
              //     // Icon(Icons.arrow_drop_down, color: Colors.red),
              //   ],
              // ),
            ],
          ),
          SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/sample.png',
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //커피이름
              Text('카페라떼(Hot)', style: MTextStyles.bold18Black),
              // 브렌드
              Text('스타벅스', style: MTextStyles.regular14BlackColor),

              // 추천수
              Row(
                children: [
                  Text('👍 50', style: MTextStyles.regular12Grey06),
                  SizedBox(width: 8),
                  Text('👎 32', style: MTextStyles.regular12Grey06),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
