import 'package:chatgpt_app/models/models_model.dart';
import 'package:chatgpt_app/providers/models_provider.dart';
import 'package:chatgpt_app/services/api_services.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel ;
  @override
  Widget build(BuildContext context) {

    final modelsProvider = Provider.of<ModelsProvider>(context, listen : false);
    currentModel = modelsProvider.getCurrentModel;

    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
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
                          modelsProvider.setCurrentModel(value.toString());
                    }
                ),
              );
        });
  }
}


//
