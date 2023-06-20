import 'dart:developer';

import 'package:chatgpt_app/constants/api_constants.dart';
import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/providers/models_provider.dart';
import 'package:chatgpt_app/services/api_services.dart';
import 'package:chatgpt_app/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../services/services.dart';
import '../widgets/chat_widget.dart';
import '../widgets/text_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      //appbar makking op 🔥🔥
        appBar: AppBar(
          elevation: 2,
          leading: Image.asset(openaiLogo).box.padding(EdgeInsets.all(8)).make(),
          title: "ChatGPT".text.white.make(),
          //--->> to add three dots in appbar 🔥🔥
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert_rounded, color: Colors.white,),
              onPressed: () async {
                //actions when you click on three dots
                await Services.showModalSheet(context: context);
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    // return "hello".text.white.make().box.padding(EdgeInsets.symmetric(horizontal: 8)).make();
                    return ChatWidget(
                      chatIndex: int.parse(
                          chatMessages[index]["chatIndex"].toString()),
                      msg: chatMessages[index]["msg"].toString(),
                    );
                  }).flexible(),

              if (_isTyping == true) ...[
                const SpinKitThreeBounce(color: Colors.white, size: 18)
              ],
              5.heightBox,

              //for senging msg portion
              Container(
                color: cardColor,
                child: Row(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      //--> jo type karege us text ki style change hogi
                      controller: textEditingController,
                      onSubmitted: (value) {
                        // value will store the msg
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "How can I help you",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ).expand(),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.white,),
                      onPressed: () async {
                        try{
                          //when we click button we get all the models same as we get during postman
                          print("request has been sent");
                          await ApiService.sendMessage(message: textEditingController.text, modelId: modelsProvider.getCurrentModel);
                        }catch(error){print("Error:- $error");}
                        },
                    )
                  ],
                ).box.padding(EdgeInsets.all(8)).make(),
              )
            ],
          ),
        ));
  }
}
