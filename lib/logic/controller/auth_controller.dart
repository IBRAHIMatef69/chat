import 'package:chat/routes/routes.dart';
import 'package:chat/services/firestore_methods.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool isVisibilty = false;

  // bool isChecked = false;
  var displayUserName = ''.obs;
  var displayUserPhoto = "".obs;
  var displayUserEmail = "".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var googleSignin = GoogleSignIn();

  var isSignedIn = false;
  final GetStorage authBox = GetStorage();

  User? get userProffile => auth.currentUser;

  @override
  void onInit() {
    displayUserName.value =
        (userProffile != null ? userProffile!.displayName : "")!;
    // displayUserPhoto.value =
    //     (userProffile.photoURL= "null" ? userProffile?.photoURL : "")!;
    displayUserEmail.value = (userProffile != null ? userProffile!.email : "")!;

    super.onInit();
  }

  void visibility() {
    isVisibilty = !isVisibilty;
    update();
  }

  // void checked() {
  //   isChecked = !isChecked;
  //   update();
  // }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        displayUserName.value = name;
        displayUserEmail.value = email;
        auth.currentUser!.updateDisplayName(name);
      });




      update();

      Get.snackbar(
        "confirm",
        "Please confirm your email by login",
        snackPosition: SnackPosition.TOP,
      );
      Get.offNamed(Routes.loginScreen);

    } on FirebaseAuthException catch (error) {
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'weak-password') {
        message = "password is too weak.";
        title = error.code.toString();

        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        message = "account already exists ";

        print('The account already exists for that email.');
      } else {
        message = error.message.toString();
      }

      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
      // Get.snackbar(
      //   title,
      //   message,
      //   snackPosition: SnackPosition.TOP,
      // );
    } catch (error) {
      Get.snackbar(
        "Error",
        "$error",
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  void loginUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        displayUserName.value = auth.currentUser!.displayName!;
        displayUserEmail.value = email;

        FireStoreMethods().userSetup(
            auth.currentUser!.displayName!,
            auth.currentUser!.email,
            auth.currentUser!.uid,
            "https://t4.ftcdn.net/jpg/00/97/00/09/360_F_97000908_wwH2goIihwrMoeV9QF3BW6HtpsVFaNVM.jpg");
        await authBox.write("uid", "${auth.currentUser!.uid}");
        await authBox.write("displayName", "${auth.currentUser!.displayName}");
        await authBox.write("email", "${auth.currentUser!.email}");
        await authBox.write("photoURL",
            "https://t4.ftcdn.net/jpg/00/97/00/09/360_F_97000908_wwH2goIihwrMoeV9QF3BW6HtpsVFaNVM.jpg");
      });
      update();
      displayUserEmail.value = email;
      displayUserName.value = auth.currentUser!.displayName!;
      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(
        Routes.mainScreen,
      );
    } on FirebaseAuthException catch (error) {
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'user-not-found') {
        message =
            "Account does not exists for that $email.. Create your account by signing up..";
      } else if (error.code == 'wrong-password') {
        message = "Invalid Password... PLease try again!";
      } else {
        message = error.message.toString();
      }
      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
      print(error);
    }
  }

  void googleSignupApp() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignin.signIn();
      displayUserName.value = googleUser!.displayName!;
      displayUserPhoto.value = googleUser.photoUrl!;
      displayUserEmail.value = googleUser.email;
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      // final User? user = auth.currentUser;
      // final uid = user!.uid;



      await auth.signInWithCredential(credential);

      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(Routes.mainScreen);
      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetailes = await result.user;
      if (result != null) {
          FireStoreMethods().userSetup (
            userDetailes!.displayName!,
            userDetailes.email,
            userDetailes.uid,
            userDetailes.photoURL);
      }
      await authBox.write("uid", "${userDetailes!.uid}");
      await authBox.write("displayName", "${userDetailes.displayName}");
      await authBox.write("email", "${userDetailes.email}");
      await authBox.write("photoURL", "${userDetailes.photoURL}");
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    }
  }

  void resetPassWord(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
      Get.defaultDialog(
          title: "Reset Password",
          middleText: "check your gmail messages",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    } on FirebaseAuthException catch (error) {
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'user-not-found') {
        message =
            "Account does not exists for that $email.. Create your account by signing up..";
      } else {
        message = error.message.toString();
      }
      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
      print(error);
    }
  }

  void signOutFromApp() async {
    try {
      await auth.signOut();
      await googleSignin.signOut();
      displayUserName.value = "";
      displayUserPhoto.value = "";
      displayUserEmail.value = "";
      isSignedIn = false;
      authBox.remove("auth");
      update();
      Get.offAllNamed(Routes.loginScreen);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    }
  }
}
//https://t4.ftcdn.net/jpg/00/97/00/09/360_F_97000908_wwH2goIihwrMoeV9QF3BW6HtpsVFaNVM.jpg
