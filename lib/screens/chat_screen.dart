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

import '../models/chat_models.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';
import '../widgets/text_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController = TextEditingController();
  late FocusNode  focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  List<ChatModel> chatlist = [];   ///we defining it outside of build because when we buil it previous chatlist remain preserve

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
                  controller: _listScrollController,
                  itemCount: chatlist.length,
                  itemBuilder: (context, index) {
                    // return "hello".text.white.make().box.padding(EdgeInsets.symmetric(horizontal: 8)).make();
                    return ChatWidget(
                      chatIndex: chatlist[index].chatIndex,
                      msg: chatlist[index].msg,
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
                      focusNode : focusNode,
                      style: TextStyle(color: Colors.white),
                      //--> jo type karege us text ki style change hogi
                      controller: textEditingController,
                      onSubmitted: (value) async{
                        // value will store the msg
                      await sendMessageFCT(modelsProvider: modelsProvider);
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "How can I help you",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ).expand(),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.white,),
                      onPressed: () async {await sendMessageFCT(modelsProvider: modelsProvider);},
                    )
                  ],
                ).box.padding(EdgeInsets.all(8)).make(),
              )
            ],
          ),
        ));
  }




  //function send message
Future<void> sendMessageFCT ({required ModelsProvider modelsProvider}) async {
  try{
    //when we click button we get all the models same as we get during postman
    setState(() {
      _isTyping = true;
      chatlist.add(ChatModel(msg: textEditingController.text, chatIndex: 0));   //0 as we are user

      textEditingController.clear();   //after tying wriitrn msg in textfild will automatically erased
      focusNode.unfocus();
    });
    //and all the response that we got from api sendmessage will store in this list
    chatlist.addAll(await ApiService.sendMessage(message: textEditingController.text, modelId: modelsProvider.getCurrentModel));
    setState(() {});
  }
  catch(error){print("Error:- $error");}
  finally{setState(() {
    _isTyping = false;
  scrollListToEnd();
  });}
}


void scrollListToEnd(){
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.easeOut,
    );
}
}
