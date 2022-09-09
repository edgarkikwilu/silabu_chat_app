import 'package:uuid/uuid.dart';

import 'package:uuid/uuid.dart';

class Chat{
  final int id;
  final String referenceId;
  final int conversationId;
  final String message;
  final String time;
  final bool read;
  final int to;
  final int from;

  Chat(this.id,this.referenceId,this.conversationId,this.message,this.time,this.read,this.to,this.from);

  Chat.fromJson(Map<String,dynamic> json):
      id=json['id'],
      referenceId=json['referenceId'],
      conversationId=json['conversationId'],
      message=json['message'],
      time=json['time'],
      read=json['read'],
      to=json['to'],
      from=json['from'];

}