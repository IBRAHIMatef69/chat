import 'package:chat/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/logic/controller/auth_controller.dart';
import 'package:chat/utils/my_string.dart';
import 'package:chat/view/widgets/auth/auth_button.dart';
import 'package:chat/view/widgets/auth/auth_text_form.dart';

import '../../../utils/theme.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.0),
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
                                controller: nameController,
                                obscureText: false,
                                validator: (value) {
                                  if (value.toString().length <= 2 ||
                                      !RegExp(validationName).hasMatch(value)) {
                                    return "Enter valid name";
                                  } else {
                                    return null;
                                  }
                                  ;
                                },
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: mmainColor,
                                ),
                                suffixIcon: Text(""),
                                hintText: "User Name"),
                            SizedBox(
                              height: height * .03,
                            ),
                            AuthTextFormField(
                                controller: emailController,
                                obscureText: false,
                                validator: (value) {
                                  if (!RegExp(validationEmail)
                                      .hasMatch(value)) {
                                    return "Invalid Email";
                                  } else {
                                    return null;
                                  }
                                },
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: mmainColor,
                                ),
                                suffixIcon: Text(""),
                                hintText: "Email"),
                            SizedBox(
                              height: height * .03,
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
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: mmainColor,
                                    ),
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
                              height: height * .02,
                            ),
                            // CheckWidget(),
                            SizedBox(
                              height: height * .03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: width * .7,
                                    child: GetBuilder<AuthController>(
                                      builder: (_) {
                                        return AuthButton(
                                          text: "Sign Up",
                                          onPressed: () {
                                            // if (controller.isChecked == false) {
                                            //   Get.defaultDialog(
                                            //       title: "",
                                            //       middleText:
                                            //           'Please accept terms & conditions',
                                            //       textCancel: "Ok",
                                            //       middleTextStyle: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold),
                                            //       buttonColor: Colors.grey,
                                            //       cancelTextColor: Colors.black,
                                            //       backgroundColor:
                                            //           Colors.grey.shade200);
                                            // }
                                            // else
                                              if (formKey.currentState!
                                                .validate()) {
                                              String name = nameController.text;

                                              //trim علشان لو في مسافات يشيلها
                                              String email =
                                                  emailController.text.trim();
                                              String password =
                                                  passController.text;
                                              controller.signUpUsingFirebase(
                                                  name: name,
                                                  email: email,
                                                  password: password);

                                            }
                                          },
                                          width: width * .7,
                                        );
                                      },
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an Account?",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed(Routes.loginScreen);
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
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
