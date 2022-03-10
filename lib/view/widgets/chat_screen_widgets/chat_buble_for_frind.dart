import 'package:chat/model/messages.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';

class ChatBubleFriend extends StatelessWidget {
  ChatBubleFriend({Key? key,required this.message}) : super(key: key);
  final  message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),

              topLeft: Radius.circular(17)),
          color: mainColor,
        ),
        child:   Text(
          "$message",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
