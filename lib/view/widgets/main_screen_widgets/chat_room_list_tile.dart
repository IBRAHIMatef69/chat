import 'package:chat/services/firestore_methods.dart';
import 'package:chat/view/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatRoomListTil extends StatefulWidget {
  final String lastMessage, chatRoomId, myUserId;
  final Timestamp lastMessageTime;

  ChatRoomListTil(
      this.lastMessage, this.chatRoomId, this.myUserId, this.lastMessageTime);

  @override
  State<ChatRoomListTil> createState() => _ChatRoomListTilState();
}

class _ChatRoomListTilState extends State<ChatRoomListTil> {
  String profilePicUrl = "", name = "", userId = "";
  bool isloading = false;

  getThisUserInfo() async {
    userId =
        widget.chatRoomId.replaceAll(widget.myUserId, "").replaceAll("_", "");

    QuerySnapshot querySnapshot = await FireStoreMethods().getUserInfo(userId);
    name = "${querySnapshot.docs[0]["displaydame"]}";
    profilePicUrl = "${querySnapshot.docs[0]["profUrl"]}";

    isloading = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getThisUserInfo();
setState(() {

});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return profilePicUrl == ""
        ? Container()

        : Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChatScreen(userId, name, profilePicUrl),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(profilePicUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${name}",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.lastMessage,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black54),
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Text(
                          "${DateFormat.jm().format(widget.lastMessageTime.toDate()).toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: .3,
                color: Colors.black54,
                indent: 10,
                endIndent: 10,
              )
            ],
          );
  }

}
