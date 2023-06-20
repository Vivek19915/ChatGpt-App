import 'dart:convert';
import 'dart:io';

import 'package:chatgpt_app/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> getModels()async{
    //try catch block
    try{
      //get request to get all the models from open ai Api
      var response = await http.get(
          Uri.parse("$BASE_URL/modelsaaa"),
        headers: {'Authorization': 'Bearer $API'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if(jsonResponse['error']!=null){
        //means error occured
        print("jsonResponse Error:- $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']['message']);
      }
      print("jsonResponse $jsonResponse");

    } catch(error){
      print("error:- $error");
    }
  }
}
