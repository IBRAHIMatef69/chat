import 'package:chat/utils/theme.dart';
import 'package:flutter/material.dart';

class Circular extends StatelessWidget {
  const Circular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: CircularProgressIndicator(
              color: mainColor,
            )));
  }
}
