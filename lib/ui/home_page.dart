import 'package:flutter/material.dart';
import 'package:nltour_collaborator/ui/screen_container.dart';
import 'package:nltour_collaborator/ui/widget/nl_menu_card.dart';

class HomeCollaboratorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeCollaboratorPageState();
  }
}

class HomeCollaboratorPageState extends State<HomeCollaboratorPage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  Widget mainScreen = HomeContainer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: NLMenuCard(),
      ),
      backgroundColor: Color(0x00ffffffff),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0x00ff008fe5)),
        backgroundColor: Color(0x00ffffffff),
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'NLTour Collaborator',
          style: TextStyle(
            color: Color(0xff008fe5),
            fontFamily: 'Normal',
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(child: mainScreen),
    );
  }
}