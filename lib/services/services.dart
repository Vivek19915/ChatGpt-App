import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';
import '../widgets/drop_down_button.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context})async{
    //since showModalBottomSheet == future we use aync and await 🔥🔥
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //to make rounded boundry
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
        ),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(label: "Choose Model : ", fontSize: 16.0,),
              ModelsDropDownWidget().flexible(),
            ],
          ).box.padding(EdgeInsets.all(12)).make();
        });
}
}
