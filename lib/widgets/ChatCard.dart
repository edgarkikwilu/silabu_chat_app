import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silabu_chat_app/controller/ChatController.dart';
import 'package:silabu_chat_app/models/Chat.dart';

class ChatCard extends StatelessWidget{

  final Chat chat;
  final ChatController _chatController = Get.find();

  ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
      decoration: BoxDecoration(
        color: chat.from==_chatController.connectionUsername?Colors.transparent:Colors.grey,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: chat.from==_chatController.connectionUsername?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          if(chat.from==_chatController.connectionUsername)
            const Text("You",style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 10,fontStyle: FontStyle.normal)),
          if(chat.referenceId.isNotEmpty)
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: chat.from==_chatController.connectionUsername?MainAxisAlignment.end:MainAxisAlignment.start,
                children: [
                  Text(chat.referenceId,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11,fontStyle: FontStyle.italic),),
                  Icon(Icons.reply)
                ],
              ),
            ),
          Text(chat.message)
        ],
      ),
    );
  }
}