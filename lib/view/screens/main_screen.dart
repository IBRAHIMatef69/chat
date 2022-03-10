import 'package:chat/logic/controller/auth_controller.dart';
import 'package:chat/logic/controller/main_controller.dart';
import 'package:chat/model/users.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/view/widgets/main_screen_widgets/chatt_rroom_llist.dart';
import 'package:chat/view/widgets/main_screen_widgets/circular_b.dart';
import 'package:chat/view/widgets/main_screen_widgets/search_user_list_tile.dart';
import 'package:chat/view/widgets/main_screen_widgets/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authController = Get.find<AuthController>();
  final mainController = Get.find<MainController>();
@override
  void initState() {
    // TODO: implement initState
  setState(() {

  });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkClr.withOpacity(.91),
      appBar: AppBar(
        backgroundColor: mmainColor,
        title: const Text(
          "Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          GetBuilder<AuthController>(builder: (_) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: "Logout",
                      titleStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      middleText: "Are you sure to logout??",
                      radius: 5,
                      textConfirm: "No",
                      textCancel: "Yes",
                      onCancel: () {
                        authController.signOutFromApp();
                      },
                      onConfirm: () {
                        Get.back();
                      },
                      buttonColor: mmainColor,
                      cancelTextColor: Colors.black,
                      confirmTextColor: Colors.white);
                },
                splashColor: mmainColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(12),
                customBorder: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          })
        ],
      ),
      body: GetBuilder<MainController>(
        builder: (_) {
          return Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              children: [
                SearchWidget(),
                mainController.textEditingController.text != "" &&
                        mainController.isSearch == true
                    ? StreamBuilder<QuerySnapshot>(
                        stream: mainController.userStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              isExisted() {
                                return mainController.list.any((element) =>
                                    element.email ==
                                    (Users.fromJson(snapshot.data!.docs[i])
                                        .email));
                              }

                              isExisted()
                                  ? null
                                  : mainController.list.add(
                                      Users.fromJson(snapshot.data!.docs[i]));
                            }

                            return Expanded(child: GetBuilder<MainController>(
                              builder: (_) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mainController
                                                .textEditingController.text ==
                                            ""
                                        ? 0
                                        : mainController.list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: SearchUserListTile(
                                          index: index,
                                        ),
                                      );
                                    });
                              },
                            ));
                          } else {
                            return Circular();
                          }
                        })
                    : Expanded(child: ChattRoomLList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
