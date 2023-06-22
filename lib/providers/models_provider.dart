import 'package:flutter/cupertino.dart';
import '../models/models_model.dart';
import '../services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";

  //getter for current choosen model to show
  String get getCurrentModel {
    return currentModel;
  }

  // getter to set current model that is chosen by us
  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();    //notifyListeners is used to notify changes to multiple listeners. It calls notifyListeners() in every setter function so every listener is aware of the change
  }

  List<ModelsModel> modelsList = [];

  //getter for model list return list of models models data type
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
