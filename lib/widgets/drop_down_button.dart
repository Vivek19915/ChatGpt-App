import 'package:chatgpt_app/models/models_model.dart';
import 'package:chatgpt_app/services/api_services.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String currentModel = "gpt-3.5-turbo";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
        future: ApiService.getModels(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return TextWidget(label: snapshot.error.toString()).box.make().centered();
          }
          return snapshot.data==null || snapshot.data!.isEmpty ? SizedBox.shrink()
              : FittedBox(
                fit: BoxFit.contain,
                child: DropdownButton(
                    dropdownColor: scaffoldBackgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                        snapshot.data!.length,
                            (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: TextWidget(
                              label: snapshot.data![index].id,
                              fontSize: 15.0,
                            ))),
                    value: currentModel,
                    onChanged: (value){
                          setState(() {
                          currentModel = value.toString();
                          });
                    }
                ),
              );
        });
  }
}


//
