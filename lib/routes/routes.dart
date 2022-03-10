import 'package:chat/logic/bindings/auth_binding.dart';
import 'package:chat/logic/bindings/main_sccreen_binding.dart';
import 'package:chat/logic/bindings/splash_binding.dart';
import 'package:chat/view/screens/auth/login_screen.dart';
import 'package:chat/view/screens/main_screen.dart';
import 'package:chat/view/screens/splash_screen.dart';
import 'package:get/get.dart';

import '../view/screens/auth/forgot_password.dart';
import '../view/screens/auth/signup_screen.dart';

class AppRoutes {
  static const welcome = Routes.usersListChat;
  static final routes = [
    // GetPage(
    //   name: Routes.search,
    //   page: () => SearchWidget(),
    //   bindings: [UsersChatListBinding()],
    // ),
    // GetPage(
    //   name: Routes.chatScreen,
    //   page: () => ChatScreen(),
    //   bindings: [AuthBinding()],
    // ),
    GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.splashScreen,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.signUpScreen,
        page: () => SignUpScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.forgetPass,
        page: () => ForgetPass(),
        binding: AuthBinding()),

    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [AuthBinding(), MainBinding()],
    ),
  ];
}

class Routes {
  static const usersListChat = "/usersListChat";
  static const loginScreen = "/loginScreen";
  static const signUpScreen = "/signUpScreen";
  static const mainScreen = "/mainScreen";
  static const forgetPass = "/ForgetPass";
  static const splashScreen = "/splashScreen";
}
