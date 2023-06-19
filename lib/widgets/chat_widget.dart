import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';
import '../services/assets_manager.dart';

Widget ChatWidget({String? msg , chatIndex}){
  return Column(
    children: [
      Row(
        children: [
          Image.asset(chatIndex==0 ? userIMage:botIMage,width: 30,),
          5.widthBox,
          TextWidget(label: msg).box.make().expand(),
        ],
      ).box.padding(EdgeInsets.all(8)).color(chatIndex==0 ? scaffoldBackgroundColor :cardColor ).make()
    ],
  );
}
