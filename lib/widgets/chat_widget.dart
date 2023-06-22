import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';
import '../services/assets_manager.dart';

Widget ChatWidget({String? msg , chatIndex}){
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(chatIndex==0 ? userIMage:botIMage,width: 30,),
          5.widthBox,
          chatIndex==0 ? TextWidget(label: msg).box.make().expand()
              : DefaultTextStyle(
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    animatedTexts: [TyperAnimatedText(msg!.trim())],
          ).expand(),
              ),

          chatIndex==0 ? SizedBox.shrink()
              : Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined,color: CupertinoColors.white,),
              5.widthBox,
              Icon(Icons.thumb_down_alt_outlined,color: CupertinoColors.white,),

            ],
          ),
        ],
      ).box.padding(EdgeInsets.all(8)).color(chatIndex==0 ? scaffoldBackgroundColor :cardColor ).make()
    ],
  );
}
