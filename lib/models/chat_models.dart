class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});


  //getting values from json
  factory ChatModel.fromJson(Map<String,dynamic> json) => ChatModel(
    msg: json["msg"],
    chatIndex: json["chatIndex"],
  );
}
