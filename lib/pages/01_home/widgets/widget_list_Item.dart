import 'package:flutter/material.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_coffee_list.dart';
import 'package:jjyourchoice/provider/provider_coffee.dart';
import 'package:jjyourchoice/style/constants.dart';
import 'package:jjyourchoice/style/textstyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class WidgetListItem extends StatelessWidget {
  const WidgetListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var provider = context.watch<ProviderCoffee>();

    List<ModelResponseGetCoffeeListData>? coffeeList =
        provider.modelResponseGetCoffeeListData;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Column(
            children: [
              Text('${index + 1}위', style: MTextStyles.bold16Black),
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
            child: CachedNetworkImage(
              imageUrl: coffeeList![index].coffee!.image!,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //커피이름
              Text(coffeeList[index].coffee!.name!,
                  style: MTextStyles.bold16Black),
              // 브렌드
              Text(coffeeList[index].coffee!.brand!,
                  style: MTextStyles.regular14BlackColor),

              // 추천수
              Row(
                children: [
                  Text('👍 ${coffeeList[index].coffee!.totalLikeCount}',
                      style: MTextStyles.regular12Grey06),
                  SizedBox(width: 8),
                  Text('👎 ${coffeeList[index].coffee!.totalHateCount}',
                      style: MTextStyles.regular12Grey06),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
