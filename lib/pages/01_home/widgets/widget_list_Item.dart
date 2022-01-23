import 'package:flutter/material.dart';
import 'package:jjyourchoice/models/coffee/model_response_get_coffee_list.dart';
import 'package:jjyourchoice/provider/provider_coffee.dart';
import 'package:jjyourchoice/style/colors.dart';
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

    var providerCoffee = context.watch<ProviderCoffee>();

    List<ModelResponseGetCoffeeListData>? coffeeList =
        providerCoffee.modelResponseGetCoffeeListData;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text('${index + 1}위', style: MTextStyles.bold16Black),
              // Text('▲ ${2}', style: MTextStyles.bold10Tomato),
              // Row(▲▼
              //   children: [
              //     // Icon(Icons.arrow_drop_down, color: Colors.red),
              //   ],
              // ),
            ],
          ),
          SizedBox(width: 12),
          Container(
            height: 80,
            width: 80,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    coffeeList![index].coffee!.temp == 'hot'
                        ? 'assets/images/hot.png'
                        : 'assets/images/ice.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 5,
                    child: coffeeList[index].coffee!.temp == 'hot'
                        ? Text(
                            'Hot',
                            style: MTextStyles.bold10Tomato,
                          )
                        : Text(
                            'Iced',
                            style: MTextStyles.bold10Blue,
                          )),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: coffeeList[index].coffee!.name!,
                      style: MTextStyles.bold16Black,
                    ),
                    // coffeeList[index].coffee!.temp == 'hot'
                    //     ? TextSpan(
                    //         text: '   Hot',
                    //         style: MTextStyles.bold10Tomato,
                    //       )
                    //     : TextSpan(
                    //         text: '   Iced',
                    //         style: MTextStyles.bold10Blue,
                    //       )
                  ]),
                  overflow: TextOverflow.ellipsis,
                ),
                //커피이름
                // Row(
                //   children: [
                //     Container(
                //       child: Text(
                //         coffeeList[index].coffee!.name!,
                //         style: MTextStyles.bold16Black,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     SizedBox(width: 8),
                //     coffeeList[index].coffee!.temp == 'hot'
                //         ? Text('Hot',
                //             style: MTextStyles.bold10Tomato,
                //             overflow: TextOverflow.ellipsis)
                //         : Text('Iced',
                //             style: MTextStyles.bold10Blue,
                //             overflow: TextOverflow.ellipsis)
                //   ],
                // ),
                // 브렌드
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: getBrandLogo(
                          providerCoffee, coffeeList[index].coffee!.brand!),
                      height: 12,
                      width: 12,
                    ),
                    SizedBox(width: 8),
                    Text(coffeeList[index].coffee!.brand!,
                        style: MTextStyles.regular14BlackColor),
                  ],
                ),

                // 추천수
                Row(
                  children: [
                    Text('👍 ${coffeeList[index].preferenceCount}',
                        style: MTextStyles.regular12Grey06),
                    SizedBox(width: 8),
                    // Text('👎 ${coffeeList[index].coffee!.totalHateCount}',
                    //     style: MTextStyles.regular12Grey06),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getBrandLogo(ProviderCoffee providerCoffee, String? brand) {
    String? brandImage;
    providerCoffee.brands!.forEach((element) {
      if (element.name == brand) {
        brandImage = element.logo;
      }
    });
    return brandImage!;
  }
}
