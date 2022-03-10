import 'package:chat/routes/routes.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/logic/controller/auth_controller.dart';
import 'package:chat/utils/my_string.dart';
import 'package:chat/view/widgets/auth/auth_button.dart';
import 'package:chat/view/widgets/auth/auth_text_form.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:pinkClr.withOpacity(.91),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              height: height,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              decoration: BoxDecoration(

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: pinkClr.withOpacity(.91),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(angle: -.2,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 29, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * .03,
                            ),
                            AuthTextFormField(
                                controller: emailController,
                                obscureText: false,
                                validator: (value) {
                                  if (!RegExp(validationEmail).hasMatch(value)) {
                                    return "Invalid Email";
                                  } else {
                                    return null;
                                  }
                                },
                                prefixIcon: Icon(Icons.email,color: mmainColor,),

                                suffixIcon: Text(""),
                                hintText: "Email"),
                            SizedBox(
                              height: height * .01,
                            ),
                            GetBuilder<AuthController>(
                              builder: (_) {
                                return AuthTextFormField(
                                    controller: passController,
                                    obscureText:
                                        controller.isVisibilty ? false : true,
                                    validator: (value) {
                                      if (value.toString().length < 6) {
                                        return "Password should be longer or equal to 6 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixIcon: Icon(Icons.lock,color: mmainColor,),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.visibility();
                                      },
                                      icon: controller.isVisibilty
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      color: Color(0xff7900FF),
                                    ),
                                    hintText: "Password");
                              },
                            ),
                            SizedBox(
                              height: height * .008,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.forgetPass);
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * .1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<AuthController>(builder: (_) {
                                  return AuthButton(
                                      text: "LogIn",
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          String email =
                                              emailController.text.trim();
                                          String password = passController.text;
                                          controller.loginUsingFirebase(
                                              email: email, password: password);
                                        }
                                      },
                                      width: width * .7);
                                })
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w400),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.signUpScreen);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                    child: Divider(
                                  color: Colors.black54,
                                  endIndent: 5,
                                  thickness: .5,
                                )),
                                Text(
                                  "Or continue with",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.black54,
                                  indent: 5,
                                  thickness: .5,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: height * .03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                GetBuilder<AuthController>(builder: (_) {
                                  return InkWell(
                                      onTap: () {
                                        controller.googleSignupApp();
                                      },
                                      child: Container(
                                        width: width * .076,
                                        height: width * .076,
                                        child: Image.asset(
                                            "assets/images/google.png"),
                                      ));
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
