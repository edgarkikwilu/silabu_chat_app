import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silabu_chat_app/controller/ChatController.dart';
import 'package:silabu_chat_app/models/Chat.dart';
import 'package:silabu_chat_app/widgets/ChatCard.dart';

class ChatPage extends StatelessWidget{
  final ChatController _chatController = Get.find();

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      id: 'chat-page',
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat Room (Drag to reference message)",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontStyle: FontStyle.italic),),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height-80,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: controller.chatScrollController,
                        shrinkWrap: true,
                        itemCount: controller.getChats().length,
                        itemBuilder: (context,index){
                          Chat chat = controller.getChats().elementAt(index);
                          return GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails dragEndDetails){
                              print("Drag ended ${dragEndDetails.velocity}");
                              controller.setReferencedChat(chat);
                            },
                            child: ChatCard(chat: chat)
                          );
                        }
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GetBuilder<ChatController>(
                      id: "message-input",
                      builder:(controller){
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: controller.getReferencedChat().message != ""?Colors.blueGrey[100]:Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(color: Colors.green)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if(controller.getReferencedChat().message != "")
                                      Container(
                                          // height:40,
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text(controller.getReferencedChat()!.message)
                                      ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      child: TextFormField(
                                        maxLines: 3,
                                        controller: controller.chatMessageController,
                                        decoration: InputDecoration(
                                            hintText: "Your message",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: (){
                                    controller.sendMessage();
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    // height: 55,
                                    width: 20,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 10,left: 5),
                                    child: const Text("Send"),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                )
                            )
                          ],
                        );
                      }
                    )
                  )

                ],
              ),
            ),
        )
        );
      },
    );
  }
}