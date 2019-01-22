import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_collaborator/controller/tour_controller.dart';
import 'package:nltour_collaborator/controller/traveler_controller.dart';
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/model/type.dart';
import 'package:nltour_collaborator/ui/mesage_page.dart';
import 'package:nltour_collaborator/ui/widget/nl_app_bar.dart';
import 'package:nltour_collaborator/ui/widget/nl_button.dart';
import 'package:nltour_collaborator/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDetailPage extends StatelessWidget {
  final Tour tour;

  const HistoryDetailPage({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Tour Detail'),
      body: buildContent(context),
    );
  }

  buildContent(BuildContext context) {
    var dateFormat = DateFormat('MMMM dd, yyyy');
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional(0, 1),
              children: <Widget>[
                Image.network(
                  tour.place.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tour.place.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Tour Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[900],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Place:'),
                            ),
                            Expanded(
                              child: Text(
                                tour.place.name,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Date:'),
                            ),
                            Expanded(
                              child: Text(
                                dateFormat.format(tour.startDate),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Status:'),
                            ),
                            Expanded(
                              child: Text(
                                getStatusString(tour),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Custommer:'),
                            ),
                            Expanded(
                              child: Text(
                                tour.traveler.firstName +
                                    ' ' +
                                    tour.traveler.lastName,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Price:'),
                            ),
                            Expanded(
                              child: Text(
                                '\$' + tour.price.toString(),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NLSimpleRoundedButton(
                            onPressed: () {
                              goToMessage(context, tour.tourGuide);
                            },
                            btnWidth: 100,
                            btnHeight: 30,
                            backgroundColor: Color(0xFF008fe5),
                            roundColor: Color(0xFF008fe5),
                            textColor: Colors.white,
                            btnText: 'Message',
                          ),
                          getStatus(tour) != 2 ? NLSimpleRoundedButton(
                            onPressed: () {
                              cancelTour(context);
                            },
                            btnWidth: 100,
                            btnHeight: 30,
                            backgroundColor: Colors.white,
                            roundColor: Color(0xFF008fe5),
                            textColor: Color(0xFF008fe5),
                            btnText: 'Cancel',
                          ): Container(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getStatus(Tour tour) {
    if (tour.tourGuide == null) {
      return 0;
    } else if (tour.startDate.isAfter(DateTime.now())) {
      return 1;
    } else {
      return 2;
    }
  }

  String getStatusString(Tour tour) {
    int stt = getStatus(tour);
    switch (stt) {
      case 0:
        return 'Finding tour guide';
      case 1:
        return 'Accepted';
      case 2:
        return 'Completed';
    }
    return '';
  }


  Future goToMessage(BuildContext context, Collaborator collaborator) async {
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    TravelerController controller = TravelerController();
    controller.findByEmail(myEmail).then((data) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagePage(
                  traveler: data,
                  collaborator: collaborator,
                )),
      );
    });
  }

  void acceptGuide(String email) {}

  String getPrice(TourGuideType type) {
    switch (type) {
      case TourGuideType.FREELANCER:
        return '\$400.0';
      case TourGuideType.STUDENT:
        return '\$250.0';
      case TourGuideType.RESIDENT:
        return '\$300.0';
      case TourGuideType.PROFESSOR:
        return '\$500.0';
    }
    return '';
  }

  cancelTour(BuildContext context) async {
    NLDialog.showLoading(context);
    TourController controller = TourController();
    await controller.cancelRegisterTour(tour);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

}
