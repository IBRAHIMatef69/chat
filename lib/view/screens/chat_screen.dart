import 'package:chat/logic/controller/main_controller.dart';
import 'package:chat/model/messages.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/view/screens/main_screen.dart';
import 'package:chat/view/widgets/chat_screen_widgets/chat_buble.dart';
import 'package:chat/view/widgets/chat_screen_widgets/chat_buble_for_frind.dart';
import 'package:chat/view/widgets/main_screen_widgets/circular_b.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';

import '../../services/firestore_methods.dart';

class ChatScreen extends StatefulWidget {
  String chatWithUserId, name, image;

  ChatScreen(this.chatWithUserId, this.name, this.image);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final authController = Get.find<AuthController>();
  //
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // CollectionReference messages =
  //     FirebaseFirestore.instance.collection(kMessagesCollection);
  //
  // TextEditingController controll = TextEditingController();
  ScrollController controllerList = ScrollController();
  String chatRoomId = "", messageId = "";
  Stream<QuerySnapshot>? messageStream;
  String myName = "", myProfPic = "", myUserId = "", myEmail = "";
  TextEditingController messageTextController = TextEditingController();

  getMyInfofromGetStorage() async {
    myUserId = await GetStorage().read("uid");
    myProfPic = await GetStorage().read("photoURL");
    myEmail = await GetStorage().read("email");
    myName = await GetStorage().read("displayName");

    chatRoomId = getChatRoomIdByUder(widget.chatWithUserId, myUserId);
  }

  getChatRoomIdByUder(
    String a,
    String b,
  ) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (messageTextController.text != "") {
      String message = messageTextController.text;
      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserId,
        "ts": lastMessageTs,
        "imageUrl": myProfPic
      };
//messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      FireStoreMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserId
        };
        FireStoreMethods()
            .updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          messageTextController.clear();
          messageTextController.text = "";
          messageId = "";
        }
      });
    }
  }

  getAndSetMessages() async {
    messageStream = await FireStoreMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfofromGetStorage();
    getAndSetMessages();
  }

  final controller = Get.find<MainController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkClr.withOpacity(.91),
      appBar: AppBar(
        leading: SizedBox(
          width: 0,
        ),
        leadingWidth: 0,
        backgroundColor: mmainColor,
        title: Row(
          children: [
            InkWell(
              onTap: () {
               Get.offAllNamed(Routes.mainScreen);
              },
              child: Icon(Icons.arrow_back_ios_outlined),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget.image),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(chatRoomId)
                      .collection("chats")
                      .orderBy("ts", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Message> messagesList = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        messagesList
                            .add(Message.fromJson(snapshot.data!.docs[i]));
                      }
                      return ListView.builder(
                          controller: controllerList,
                          reverse: true,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index].sendBy == myUserId
                                ? ChatBubleFriend(
                                    message: messagesList[index].message,
                                  )
                                : ChatBuble(
                                    message: messagesList[index].message,
                                  );
                          });
                    } else {
                      return Circular();
                    }
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: mainColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(25)),
                          child: TextField(
                            // onChanged: (value) {
                            //   addMessage(false);
                            // },
                            controller: messageTextController,
                            cursorColor: Color(0xFF000000),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "type a message..",
                                border: InputBorder.none),
                          ))),
                  GetBuilder<MainController>(
                    builder: (_) {
                      return Transform.rotate(
                          angle: 100,
                          child: IconButton(
                              onPressed: () {
                                addMessage(true);
                              },
                              icon: Icon(
                                Icons.send,
                                color: mmainColor,
                                size: 30,
                              )));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
