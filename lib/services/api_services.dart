import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chatgpt_app/constants/api_constants.dart';
import 'package:chatgpt_app/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels()async{
    //try catch block
    try{
      //get request to get all the models from open ai Api
      var response = await http.get(
          Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if(jsonResponse['error']!=null){
        //means error occured
        // print("jsonResponse Error:- $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']['message']);
      }
      print("jsonResponse $jsonResponse");

      List temp=[];
      for(var value in jsonResponse["data"]){
        temp.add(value);
        // print(value["id"]);      //---> all ids will print like davinci ,babbage .....
      }
      return ModelsModel.modelsFromSnapshot(temp);

    } catch(error){
      print("error:- $error");
      rethrow;
    }
  }
}
