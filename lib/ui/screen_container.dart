import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nltour_collaborator/controller/tour_controller.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/ui/widget/nl_big_card.dart';

class HomeContainer extends StatefulWidget {
  @override
  HomeContainerState createState() {
    return new HomeContainerState();
  }
}

class HomeContainerState extends State<HomeContainer> {

  TextEditingController _tourController = TextEditingController();
  List<Tour> _tours = List<Tour>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 9.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildSearchBar(context),
            buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
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
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
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
            controller: _tourController,
          ),
          suggestionsCallback: (pattern) async {
            var tourController = TourController();
            _tours = await tourController.getAll();
            var suggestion = List<String>();
            for (Tour t in _tours) {
              suggestion.add(t.place.name);
            }
            return suggestion;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: (suggestion) {
            _tourController.text = suggestion;
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children: snapshot.data,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: buildCardTours(),
      ),
    );
  }

  Future<List<Widget>> buildCardTours() async {
    var res = List<Widget>();
    if(_tours.length != 0) {
      for (Tour t in _tours) {
        final card = BigCard(tour: t,);
        res.add(card);
      }
      return res;
    }
    var tourController = TourController();
    List<Tour> tours = await tourController.getAll();
    for (Tour t in tours) {
      final card = BigCard(tour: t,);
      res.add(card);
    }
    return res;
  }
}
