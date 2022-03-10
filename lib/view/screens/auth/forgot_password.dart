import 'package:chat/logic/controller/auth_controller.dart';
import 'package:chat/utils/my_string.dart';
import 'package:chat/utils/theme.dart';
import 'package:chat/view/widgets/auth/auth_button.dart';
import 'package:chat/view/widgets/auth/auth_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPass extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:pinkClr.withOpacity(.91),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(height: height,
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
                    children:   [
                      Transform.rotate(angle: -.2,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 29, fontWeight: FontWeight.w900),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .04,
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
                            height: height * .2,
                          ),
                          SizedBox(
                            height: height * .1,
                          ),
                          GetBuilder<AuthController>(builder: (_) {
                            return AuthButton(
                                text: "Send",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.resetPassWord(
                                        emailController.text.trim());
                                  }
                                },
                                width: width * .7);
                          })
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
    );
  }
}
