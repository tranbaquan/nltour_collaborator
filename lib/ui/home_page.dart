import 'package:flutter/material.dart';
import 'package:speech_bubble/speech_bubble.dart';

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

  // --ANIMATION

  // --DRAWER
  var name = '';
  var address = '';
  var title = '';
  var titleAppBar = 'Home';
  Widget screenTest = HomeContainer();

  Drawer _buildProfileDrawer(context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 305,
            child: new DrawerHeader(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 84,
                      width: 84,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x80000000),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(42),
                        child: new Image.asset(
                          'imgs/travel1.jpg',
                          fit: BoxFit.cover,
                          height: 84,
                          width: 84,
                        ),
                      ),
                    ),
                    new Text(
                      this.name = 'Dinh Chi Thien',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Normal',
                      ),
                    ),
                    new Text(
                      this.address = 'Ho Chi Minh City',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Semilight',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                '17',
                                style: TextStyle(
                                    fontFamily: 'Semilight',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                'TRIPS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: 'Semilight',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                '2',
                                style: TextStyle(
                                    fontFamily: 'Semilight',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                'PENDING TOURS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: 'Semilight',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                '9',
                                style: TextStyle(
                                    fontFamily: 'Semilight',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                'RATING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: 'Semilight',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00ff008fe5),
                      Color(0x00ff3eb43e),
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0, 1.5),
                        blurRadius: 1.5)
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.screenTest = HomeContainer();
                        this.titleAppBar = 'Home';
                        print('home');
                      });
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Update information',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.screenTest = UpdateInformationPage();
                        this.titleAppBar = 'Update information';
                        print('update information');
                      });
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            'Pending tour',
                            style: TextStyle(
                              color: Color(0x00ff444444),
                              fontFamily: 'Semilight',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              this.screenTest = PendingTourPage();
                              this.titleAppBar = 'Pending tour';
                              print('pending tour');
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SpeechBubble(
                        nipLocation: NipLocation.LEFT,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            'Payment',
                            style: TextStyle(
                              color: Color(0x00ff444444),
                              fontFamily: 'Semilight',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              this.screenTest = PaymentPage();
                              this.titleAppBar = 'Payment';
                              print('payment');
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SpeechBubble(
                        nipLocation: NipLocation.LEFT,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'View history',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.screenTest = HistoryPage();
                        this.titleAppBar = 'View history';
                        print('history');
                      });
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Privacy Policy | Term of Use',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.screenTest = PrivacyPage();
                        this.titleAppBar = 'Privacy Policy | Term of Use';
                        print('privacy policy');
                      });
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.screenTest = HomeContainer();
                        print('sign out');
                      });
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --DRAWER

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildProfileDrawer(context),
      backgroundColor: Color(0x00ffffffff),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0x00ff008fe5)),
        backgroundColor: Color(0x00ffffffff),
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          titleAppBar,
          style: TextStyle(
            color: Color(0xff008fe5),
            fontFamily: 'Normal',
          ),
          textAlign: TextAlign.center,
        ),
      ),
//      body: HomeContainer(),
      body: Container(child: screenTest),
    );
  }
}