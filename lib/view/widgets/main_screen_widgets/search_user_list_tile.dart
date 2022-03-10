import 'package:chat/logic/controller/main_controller.dart';
import 'package:chat/services/firestore_methods.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserListTile extends StatelessWidget {
int index;
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {return ListTile(
      onTap: ()
      {
        var chatRoomId = mainController
            .getChatRoomIdByUder(
            mainController.list[index].uid,
            mainController.myUid);

        Map<String, dynamic> chatRoomInfoMap = {
          "users": [
            mainController.myUid,
            mainController.list[index].uid
          ]
        };
        FireStoreMethods().createChatRoom(
            chatRoomId, chatRoomInfoMap);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ChatScreen(
                    mainController.  list[index].uid,
                    mainController.                    list[index].displaydame,
                    mainController.    list[index].profUrl),
          ),
        );
      },
      hoverColor: mainColor,
      focusColor: mainColor,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(mainController.list[index].profUrl),
      ),
      title: Text(mainController.list[index].displaydame),
      subtitle: Text(mainController.list[index].email),
    );  },);
  }

SearchUserListTile({
    required this.index,

  });
}
