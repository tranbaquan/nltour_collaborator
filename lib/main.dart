import 'package:flutter/material.dart';
import 'package:nltour_collaborator/routes.dart';

void main() => runApp(NLTour());

class NLTour extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLTour Collaborator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionColor: Color(0xFF008fe5),
        cursorColor: Color(0xFF008fe5),
        primaryColor: Color(0xFF008fe5),
        accentColor: Color(0xFF3eb43e),
        primaryColorDark: Colors.green,
        fontFamily: 'Semilight'
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
