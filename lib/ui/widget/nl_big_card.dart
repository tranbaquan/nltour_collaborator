import 'package:flutter/material.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/ui/widget/nl_dialog.dart';

class BigCard extends StatelessWidget {
  final Tour tour;

  const BigCard({
    Key key,
    this.tour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Dialogs dialogs = Dialogs();

    final _confirmWidget = Container(
      child: SizedBox(
//        height: 300.0,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Color(0xff008fe5),
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
                  startDate,
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
                  nameTraveler,
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
                          national,
                          style: TextStyle(color: Color(0xff333333)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Language: '),
                        Text(
                          language,
                          style: TextStyle(color: Color(0xff333333)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  descOfTraveler,
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
      margin: EdgeInsets.all(7.0),
      child: SizedBox(
        height: 225.0,
        child: GestureDetector(
          onTap: () {
            dialogs.confirm(
                context, 'Confirm Get Tour', _confirmWidget, 'NO', 'GET TOUR');
          },
          child: Card(
            elevation: 1.0,
            color: Color(0xffffffff),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Color(0xff008fe5),
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
                    startDate,
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
                    nameTraveler,
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
                            national,
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Language: '),
                          Text(
                            language,
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    descOfTraveler,
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: 'Semilight',
                      fontSize: 12.0,
                      color: Color(0xff383838),
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
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
