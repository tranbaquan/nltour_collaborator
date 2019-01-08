import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/ui/widget/nl_dialog.dart';

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
    Dialogs dialogs = Dialogs();

    final _confirmWidget = Container(
      child: SizedBox(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Color(0xff008fe5),
                ),
                title: Text(
                  widget.tour.place.address.address,
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
              ListTile(
                title: Text(
                  widget.tour.traveler.firstName +
                      " " +
                      widget.tour.traveler.lastName,
                  style: TextStyle(
                    fontFamily: 'Normal',
                    fontSize: 14.0,
                    color: Color(0xff3eb43e),
                  ),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('National:    '),
                        Text(
                          widget.tour.traveler.address.country,
                          style: TextStyle(color: Color(0xff333333)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Language: '),
                        Text(
                          widget.tour.traveler.languages.primaryLanguage,
                          style: TextStyle(color: Color(0xff333333)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  widget.tour.description == null
                      ? ""
                      : widget.tour.description,
                  style: TextStyle(
                    fontFamily: 'Semilight',
                    fontSize: 12.0,
                    color: Color(0xff383838),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      height: 225.0,
      margin: EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: () {
          dialogs.confirm2(
              context, 'Confirm Get Tour', _confirmWidget, 'NO', 'GET TOUR');
        },
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
                  widget.tour.place.address.address,
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
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Text(
                          widget.tour.description == null
                              ? ""
                              : widget.tour.description,
                          maxLines: 3,
                          style: TextStyle(
                            fontFamily: 'Semilight',
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
  })  : assert(address != null),
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
