import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchByDCT = Container(
      margin: const EdgeInsets.only(bottom: 1.0),
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          border: Border.all(
            color: Color(0xff008fe5),
            width: 1.0,
            style: BorderStyle.solid,
          )),
      child: Container(
        margin: EdgeInsets.only(right: 3.0),
        child: TextField(
//            onChanged: ,
          style: TextStyle(
            color: Color(0xff008fe5),
            fontSize: 14.0,
            fontFamily: 'Semilight',
          ),
          decoration: const InputDecoration(
            hintText: 'Place..',
            hintStyle: TextStyle(
              color: Color(0x80008fe5),
            ),
            icon: Icon(
              Icons.search,
              color: Color(0xff008fe5),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );

    final card = BigCard(
      address: 'Ben Thanh Market',
      startDate: '9:00 AM January 2019',
      nameTraveler: 'Bruce Lee',
      national: 'US',
      language: 'English',
      descOfTraveler: 'I would like to travel Ben Thanh Market. '
          'If you have time, go to visit Ben Thanh night market, which is hold in outside area and opens from 6.00pm. '
          'It includes about 200 stalls and contributes to create the unique highlight for picturesque life in Ho Chi Minh City.',
    );

    final _listCard = Container(
      height: MediaQuery.of(context).size.height - 158.0,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      child: ListView(
        children: <Widget>[
          card,
          card,
          card,
          card,
          card,
        ],
      ),
    );

    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 9.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _searchByDCT,
            _listCard,
          ],
        ),
      ),
    );
  }
}