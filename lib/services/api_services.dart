import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chatgpt_app/constants/api_constants.dart';
import 'package:chatgpt_app/models/chat_models.dart';
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



  //Send Message
  static Future<List<ChatModel>> sendMessage({required String message , required String modelId}) async {
    //try catch block
    try{
      //get request to get all the models from open ai Api
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          //here modelID model chosen by user
          // message -- messageby user
          "model": modelId,
          "messages": [{"role": "user", "content": message}],
          "temperature": 0.7
        },),
      );

      Map jsonResponse = jsonDecode(response.body);
      if(jsonResponse['error']!=null){
        //means error occured
        // print("jsonResponse Error:- $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']['message']);
      }

      // creating List<ChatModel> since function return this type of data
      List<ChatModel> chatlist = [];

      if (jsonResponse["choices"].length > 0) {
        //according to response of gpt-3.5-turbo
        // print("jsonResponse[choices]text ${jsonResponse["choices"][0]["message"]["content"]}");

        chatlist = List.generate(jsonResponse["choices"].length, (index) =>
            ChatModel(msg: jsonResponse["choices"][index]["message"]["content"],
                chatIndex: 1,         //as it is for the user
            ));
      }
      return chatlist;
    } catch(error){
      print("error11:- $error");
      rethrow;
    }
  }
}
