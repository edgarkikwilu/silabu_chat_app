import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationCard extends StatelessWidget{
  const ConversationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey,width: 0.1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 2,
            child: CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 26
            )
          ),
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Edgar Kikwilu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("Good afternoon handsome", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300))
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("12:20", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                ],
              )
          ),
        ],
      ),
    );
  }
}