import 'package:chat/logic/controller/main_controller.dart';
import 'package:chat/view/widgets/main_screen_widgets/chat_room_list_tile.dart';
import 'package:chat/view/widgets/main_screen_widgets/circular_b.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChattRoomLList extends StatefulWidget {
  ChattRoomLList({Key? key}) : super(key: key);

  @override
  State<ChattRoomLList> createState() => _ChattRoomLListState();
}

class _ChattRoomLListState extends State<ChattRoomLList> {
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: mainController.chatRoomStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        return snapshot.hasData
            ? snapshot.data!.docs.length == 0
            ? Center(
            child: const Text(
              "Search New Friends...",
              style: TextStyle(color: Colors.black87),
            ))
            : GetBuilder<MainController>(builder: (_) {return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return ChatRoomListTil(ds["lastMessage"], ds.id,
                  mainController.myUid, ds["lastMessageSendTs"]);

              // Text(
              //   ds.id.replaceAll(uid, "").replaceAll("_", ""));
            }); },)
            : Circular();

      },
    );
  }
}
