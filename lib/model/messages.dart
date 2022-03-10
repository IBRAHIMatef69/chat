import 'package:chat/utils/my_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String imageUrl;
  final String message;
  final String sendBy;
  final Timestamp ts;

  Message(this.imageUrl, this.message, this.sendBy, this.ts);

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData["imageUrl"],
      jsonData["message"],
      jsonData["sendBy"],
      jsonData["ts"],
    );
  }
}
