import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nltour_collaborator/controller/collaborator_controller.dart';
import 'package:nltour_collaborator/controller/traveler_controller.dart';
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/traveler.dart';
import 'package:nltour_collaborator/ui/mesage_page.dart';
import 'package:nltour_collaborator/ui/widget/nl_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageListPage extends StatefulWidget {
  @override
  MessageListPageState createState() {
    return new MessageListPageState();
  }
}

class MessageListPageState extends State<MessageListPage>
    with AutomaticKeepAliveClientMixin {
  CollectionReference messagesCollectionReference;
  Collaborator me;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'My Messages'),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildBody(context);
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getInfo(),
      ),
    );
  }

  buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<QuerySnapshot>(
        stream: messagesCollectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center();
            default:
              return Container(
                child: ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return FutureBuilder<Traveler>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                goToMessage(context, snapshot.data);
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Stack(
                                      alignment: AlignmentDirectional(1, 1),
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                              snapshot.data.avatar),
                                        ),
                                        Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            color: Color(0xff00ff00),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.firstName +
                                              ' ' +
                                              snapshot.data.lastName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(snapshot.data.email),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:
                                          Image.network(snapshot.data.avatar),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      future: findTarget(document),
                    );
                  }).toList(),
                ),
              );
          }
        },
      ),
    );
  }

  Future<Traveler> findTarget(DocumentSnapshot document) async {
    String email = document['email'];
    TravelerController controller = TravelerController();
    Traveler traveler = await controller.findByEmail(email);
    return traveler;
  }

  Future<Collaborator> getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    CollaboratorController controller = CollaboratorController();
    me = await controller.findByEmail(email);
    messagesCollectionReference = Firestore.instance
        .collection('messages/' + me.personalID + '/conversations');
    return me;
  }

  Future goToMessage(BuildContext context, Traveler traveler) async {
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    CollaboratorController controller = CollaboratorController();
    controller.findByEmail(myEmail).then((data) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagePage(
                  traveler: traveler,
                  collaborator: data,
                )),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
