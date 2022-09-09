import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:silabu_chat_app/models/Chat.dart';
import 'package:silabu_chat_app/models/Conversation.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController{

  TextEditingController chatMessageController = TextEditingController();
  ScrollController chatScrollController = ScrollController();
  late StompClient stompClient;

  List<Conversation> _conversationList = [];
  List<Chat> _chatList = [];
  late Conversation _selectedConversation;
  late int connectionUsername;
  late Chat _referencedChat = Chat(0, "", 0, "", "", false, 0, 0);


  @override
  void onInit() {
    super.onInit();
    int randomNumber = Random().nextInt(1000) + 1;
    connectionUsername = randomNumber;
    print("my username: $connectionUsername");
    connectToSocket();
    mockChats();
  }

  List<Conversation> getConversations() => _conversationList;
  List<Chat> getChats() => _chatList;
  Conversation getSelectedConversation() => _selectedConversation;
  Chat getReferencedChat() => _referencedChat;

  setConversation(List<Conversation> conversationList){
    _conversationList = conversationList;
  }

  setReferencedChat(Chat referencedChat){
    _referencedChat = referencedChat;
    update(['message-input']);
  }

  setChat(List<Chat> chatList){
    _chatList = chatList;
  }

  setSelectedConversation(Conversation conversation){
    _selectedConversation = conversation;
    update(['chat-page']);
  }

  sendMessage(){
    Chat newChat = Chat(1, _referencedChat.message,0, chatMessageController.text, "${DateTime.now()}", true,23, connectionUsername);
    _referencedChat = Chat(0, "", 0, "", "", false, 0, 0);
    _chatList.add(newChat);
    chatMessageController.clear();
    // chatScrollController.animateTo(
    //   0.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
    stompClient.send(
      destination: '/echo',
      body: json.encode({"id":1,"from": newChat.from,"to":newChat.to,"conversationId":newChat.conversationId,"referenceId":newChat.referenceId,
        "message":newChat.message,"read":false,"time":"${DateTime.now()}"})
    );
    update(['chat-page','message-input']);
    chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
  }

  connectToSocket(){
    Map<String,String> headers = {};
    // headers['username'] = connectionUsername;
    stompClient = StompClient(
        config: StompConfig(
          url: "ws://10.0.2.2:3000/ws",
          stompConnectHeaders: headers,
          connectionTimeout: const Duration(seconds: 3),
          onConnect: onConnectCallback,
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
        )
    );
    stompClient.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    print("stomp has been connected");
    print("${connectFrame.headers}");
    stompClient.subscribe(destination: '/echo', headers: {}, callback: (frame) {
      // Received a frame for this subscription
      String d = String.fromCharCodes(frame.binaryBody!);
      print(d);
      var result = json.decode(d);
      print("message received destination:>> ${result['to']}, myUsername: $connectionUsername");
      print("equals: ${result['to']==connectionUsername}");
      if(result['from'] != connectionUsername){
        print("inside>>>");
        Chat newChat = Chat.fromJson(result);
        _chatList.add(newChat);
        update(['chat-page']);
        chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
      }
    });
  }

  mockChats(){
    for(int i=0;i<1;i++){
      List<Chat> chats = [];
      for(int j=0;j<5;j++){
        Chat chat = Chat(j, Random().nextInt(10)%2==0?"Hello":"", Random().nextInt(10)%2==0?1:connectionUsername, "Hello random message $j",
            "${DateTime.now()}",Random().nextInt(10)%2==0?true:false,Random().nextInt(10)%2==0?1:2,j%2!=0?2:connectionUsername);
        chats.add(chat);
        _chatList.add(chat);
      }
      Conversation conversation = Conversation(i, "Chat $i", i%2==0?'255656724750':"255763006587", chats);
      _conversationList.add(conversation);
    }
  }

}