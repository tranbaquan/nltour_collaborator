import 'package:flutter/material.dart';

class NLAppbar {
  static AppBar buildAppbar(BuildContext context, String name) {
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Color(0x00ff008fe5)),
      backgroundColor: Color(0x00ffffffff),
      elevation: 1.0,
      centerTitle: true,
      title: Text(
        name,
        style: TextStyle(
          color: Color(0xff008fe5),
          fontFamily: 'Normal',
        ),
        textAlign: TextAlign.center,
      ),
    );
    return appBar;
  }
}