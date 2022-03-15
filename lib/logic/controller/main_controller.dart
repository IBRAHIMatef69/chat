import 'package:chat/model/users.dart';
import 'package:chat/services/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  bool isSearch = false;
  bool refreshh = false;

  Stream<QuerySnapshot>? userStream, chatRoomStream;
  List<dynamic> list = <Users>[].obs;
  List<dynamic> searchList = <QuerySnapshot<Users>>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    getChatRooms();
    getAll();
    super.onInit();
  }

  CollectionReference messages = FirebaseFirestore.instance.collection("Users");

  getChatRoomIdByUder(String a,
      String b,) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
    update();
  }

  var myUid = GetStorage().read("uid");

  var uid = GetStorage().read("uid");

  onSearchBtnClick() async {
    // userStream = await FireStoreMethods().GetUserByUserName(textEditingController.text);
    userStream = await messages
        .where("displaydame", isGreaterThanOrEqualTo: textEditingController.text)
        .snapshots();
    isSearch = true;
    print("/////////");

    update();
  }

  clearSearch() {
    list = [];
    textEditingController.clear();
    update();
  }

  getChatRooms() async {
    chatRoomStream = await FireStoreMethods().getChatRooms();

    update();
  }

  getAll() {
    getChatRooms();

    clearSearch();
    isSearch = false;
    update();
  }

}
