import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_collaborator/controller/collaborator_controller.dart';
import 'package:nltour_collaborator/controller/tour_controller.dart';
import 'package:nltour_collaborator/model/place.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/model/traveler.dart';
import 'package:nltour_collaborator/ui/mesage_page.dart';
import 'package:nltour_collaborator/ui/widget/nl_button.dart';
import 'package:nltour_collaborator/ui/widget/nl_dialog.dart';
import 'package:nltour_collaborator/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NLHistory extends StatelessWidget {
  final Tour tour;

  const NLHistory({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('MMM dd, yyyy');
    final widget = Container(
      height: 150,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(1.5, 0),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                tour.place.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tour.place.name,
                    style: TextStyle(fontFamily: 'Normal'),
                  ),
                  Text(
                    "Customer: " +
                        tour.traveler.lastName +
                        " " +
                        tour.traveler.firstName,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Semilight',
                    ),
                  ),
                  Text(
                    "Price: " + tour.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Semilight',
                    ),
                  ),
                  Text(
                    "Date: " + dateFormat.format(tour.startDate),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Semilight',
                    ),
                  ),
                  Text(
                    "Status: " + getStatus(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Semilight',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SimpleRoundButton(
                        btnHeight: 30,
                        btnWidth: 80,
                        btnText: 'Message',
                        onPressed: () {
                          goToMessage(context, tour.traveler);
                        },
                        roundColor: Color(0xFF008fe5),
                        backgroundColor: Color(0xFF008fe5),
                        textColor: Colors.white,
                      ),
//                      SimpleRoundButton(
//                        btnHeight: 30,
//                        btnWidth: 80,
//                        btnText: 'Cancel',
//                        onPressed: cancelTour(context),
//                        roundColor: Color(0xFF008fe5),
//                        backgroundColor: Colors.white,
//                        textColor: Color(0xFF008fe5),
//                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return widget;
  }

  String getStatus() {
    print(json.encode(tour));
    if (tour.tourGuide == null) {
      return "Pending";
    } else if (tour.startDate.isAfter(DateTime.now())) {
      return "Accepted";
    } else {
      return "Completed";
    }
  }

  Future goToMessage(BuildContext context, Traveler traveler) async {
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    CollaboratorController controller = CollaboratorController();
    controller.findByEmail(myEmail).then((data) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MessagePage(
                  traveler: traveler,
                  collaborator: data,
                )),
      );
    });
  }
}

class NLCardPlaceExpand extends StatelessWidget {
  final Place place;

  const NLCardPlaceExpand({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      height: 150,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(1.5, 0),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    place.name,
                    style: TextStyle(fontFamily: 'Normal'),
                  ),
                  Expanded(
                    child: Text(
                      place.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Semilight',
                      ),
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: RaisedOutlineButton(
                      height: 25,
                      onPressed: () {
                        Dialogs dialog = Dialogs();
                        dialog.confirm(context, place, _showDetail(place));
                      },
                      child: Text(
                        'View',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    return widget;
  }

  Widget _showDetail(Place place) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                place.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Semilight',
                ),
              ),
              Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
