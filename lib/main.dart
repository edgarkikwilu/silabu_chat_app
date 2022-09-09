import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silabu_chat_app/ChatPage.dart';
import 'package:silabu_chat_app/controller/ChatController.dart';
import 'package:silabu_chat_app/models/Conversation.dart';
import 'package:silabu_chat_app/widgets/ConversationCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ChatController _chatController = Get.put(ChatController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Silabu App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        builder: (controller)=> Scaffold(
          appBar: AppBar(
            title: const Text("Chat App"),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.getConversations().length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Conversation conv = controller.getConversations().elementAt(index);
                          controller.setSelectedConversation(conv);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
                        },
                        child: ConversationCard(),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
