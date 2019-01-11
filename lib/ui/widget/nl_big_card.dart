import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_collaborator/controller/tour_controller.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/ui/widget/nl_button.dart';
import 'package:nltour_collaborator/ui/widget/nl_dialog.dart';
import 'package:nltour_collaborator/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BigCard extends StatefulWidget {
  final Tour tour;

  const BigCard({Key key, this.tour}) : super(key: key);

  @override
  BigCardState createState() {
    return new BigCardState();
  }
}

class BigCardState extends State<BigCard> {
  DateFormat d = DateFormat("MMM dd, yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7.0),
      child: Card(
        elevation: 1.0,
        color: Color(0xffffffff),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Color(0xff008fe5),
              ),
              title: Text(
                widget.tour.place.name,
                style: TextStyle(
                  color: Color(0xff008fe5),
                  fontSize: 14.0,
                  fontFamily: 'Normal',
                ),
              ),
              subtitle: Text(
                d.format(widget.tour.startDate),
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Light',
                ),
              ),
            ),
            Divider(
              color: Color(0xff383838),
              indent: 19.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.tour.traveler.firstName +
                            ' ' +
                            widget.tour.traveler.lastName,
                        style: TextStyle(
                          fontFamily: 'Normal',
                          fontSize: 14.0,
                          color: Color(0xff3eb43e),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'National: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.tour.traveler.address.country,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Language: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.tour.traveler.languages.primaryLanguage,

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SimpleRoundButton(
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF3eb43e),
                          roundColor: Color(0xFF3eb43e),
                          btnWidth: 90,
                          btnHeight: 30,
                          btnText: 'View Info',
                          onPressed: () {
                            registerTour(widget.tour);
                          },
                        ),
                        SimpleRoundButton(
                          textColor: Colors.white,
                          backgroundColor: Color(0xFF008fe5),
                          roundColor: Color(0xFF008fe5),
                          btnWidth: 90,
                          btnHeight: 30,
                          btnText: 'Register',
                          onPressed: () {
                            registerTour(widget.tour);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  registerTour(Tour tour) async {
    NLDialog.showLoading(context);
    TourController controller = TourController();
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    bool data = await controller.registerTour(tour.id, email);
    Navigator.of(context).pop();
    if (data) {
      NLDialog.showInfo(context, 'Register Successed',
          'Please check your tour in pending tours');
    } else {
      NLDialog.showInfo(context, 'Register Failed', 'Oops... sorry!');
    }

  }
}

class HistoryTourCard extends StatelessWidget {
  final String address;
  final String time;
  final bool isPaid;
  final actionText;

  const HistoryTourCard({
    Key key,
    this.address,
    this.time,
    this.isPaid,
    this.actionText,
  })
      : assert(address != null),
        assert(time != null),
        assert(isPaid != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Dialogs dialogs = Dialogs();

    return Container(
      margin: EdgeInsets.all(7),
      child: SizedBox(
        height: 83,
        child: GestureDetector(
          onTap: () {
            // TODO
          },
          child: Card(
            elevation: 3.0,
            color: Color(0xffffffff),
            child: ListTile(
              leading: Icon(
                Icons.payment,
                color: isPaid ? Color(0xff3eb43e) : Color(0xffff3b30),
              ),
              title: Text(
                address,
                style: TextStyle(
                  color: Color(0xff008fe5),
                  fontSize: 14.0,
                  fontFamily: 'Normal',
                ),
              ),
              subtitle: Text(
                time,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Light',
                ),
              ),
              trailing: isPaid
                  ? Text(
                'See detail...',
                style: TextStyle(
                  color: Color(0xff898989),
                  fontFamily: 'Semilight',
                  fontSize: 11,
                ),
              )
                  : Text(
                'Pay Now',
                style: TextStyle(
                  color: Color(0xff008fe5),
                  fontFamily: 'Normal',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
