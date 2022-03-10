import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class FireStoreMethods {
  // addUserInfoToFireStore(String userId, Map<String, dynamic> userInfoMap) {
  //   FirebaseFirestore.instance.collection('users').doc(userId).set(userInfoMap);
  // }

  Future<void> userSetup(String displayName, email, uid, profUrl) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users.doc(uid).set({
      'displaydame': displayName,
      'uid': uid,
      'email': email,
      "profUrl": profUrl
    });
    return;
  }

  Future<Stream<QuerySnapshot>> GetUserByUserName(String userName) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("displaydame", isEqualTo: userName)
        .snapshots();
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (snapShot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts")
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChatRooms() async {
    String myName = await GetStorage().read("uid");
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myName)
        .snapshots();
  }

   Future<QuerySnapshot> getUserInfo(String userId) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: userId).get();
  }
}
