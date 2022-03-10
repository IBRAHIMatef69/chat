import 'package:chat/logic/controller/splash_controller.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
    SplashScreen({Key? key}) : super(key: key);
final controller =Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .34,
              child: Image.asset(
                "assets/images/undraw_Chat_re_re1u.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Let's Chat",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54),
                ),SizedBox(width: 40,)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            )
          ],
        ),
      ),
    );
  }
}
