 import 'package:chat/logic/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put( MainController(),permanent:  false);

  }
}
