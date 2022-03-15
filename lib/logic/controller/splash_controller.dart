import 'package:chat/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    Future.delayed(
        Duration(seconds: 2), () {
      Get.offNamed(Routes.mainScreen);
    });
    super.onInit();
  }
}
