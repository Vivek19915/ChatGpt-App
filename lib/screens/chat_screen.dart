import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar makking op 🔥🔥
        appBar: AppBar(
          elevation: 2,
          leading: Image.asset(openaiLogo).box.padding(EdgeInsets.all(8)).make(), //-->>this is the way to use constants.dart 🔥
          title: "ChatGPT".text.white.make(),
          //--->> to add three dots in appbar 🔥🔥
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert_rounded, color: Colors.white,
              ),
              onPressed: () async {
                //actions when you click on three dots
                //since showModalBottomSheet == future we use aync and await 🔥🔥
                await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
                      // borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    backgroundColor: scaffoldBackgroundColor,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Flexible(
                            //     child: TextWidget(label: "Choose Model : ", fontSize: 16,)),
                            // DropDownWidget(),
                          ],
                        ),
                      );
                    });
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
                //OP THING ---> neeche 3 boucing dots
                const SpinKitThreeBounce(color: Colors.white, size: 18)
              ],

              SizedBox(
                height: 5,
              ),

              //for senging msg portion
              Container(
                color: cardColor,
                child: Row(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      //--> jo type karege us text ki style change hogi
                      controller: textEditingController,
                      //when user send msg then what we have to do with that msg
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
                      onPressed: () {},
                    )
                  ],
                ).box.padding(EdgeInsets.all(8)).make(),
              )
            ],
          ),
        ));
  }
}
