import 'package:silabu_chat_app/models/Chat.dart';

class Conversation{
  final int id;
  final String name;
  final String conversantUsername;
  final List<Chat> chats;

  Conversation(this.id,this.name,this.conversantUsername,this.chats);

  Conversation.fromJson(Map<String,dynamic> json):
        id=json['id'],
        name=json['name'],
        conversantUsername=json['conversantUsername'],
        chats=json['chats'];
}