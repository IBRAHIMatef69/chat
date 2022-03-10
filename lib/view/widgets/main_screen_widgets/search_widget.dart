import 'package:chat/logic/controller/main_controller.dart';
import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;

    return GetBuilder<MainController>(
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .03),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: hight * .06,
              decoration: BoxDecoration(
                  color: mainColor.withOpacity(.25),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                onChanged: (value) {
                  if (value != "") {
                    controller.onSearchBtnClick();
                  }
                },
                controller: controller.textEditingController,
                cursorColor: Color(0xFF000000),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon  :controller.textEditingController.text==""? Text(""): IconButton(
                      icon: Icon(Icons.clear,color: Colors.black54,), onPressed: () { controller.clearSearch(); },
                    ),
                  prefixIcon  : IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        if (controller.textEditingController.text != "") {
                          controller.onSearchBtnClick();
                        }
                      },
                    ),
                    hintText: "Search..",
                    border: InputBorder.none),
              )),
        );
      },
    );
  }
}
