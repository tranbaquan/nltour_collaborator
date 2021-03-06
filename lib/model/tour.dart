import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/place.dart';
import 'package:nltour_collaborator/model/traveler.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {
  String id;
  Place place;
  Traveler traveler;
  Collaborator tourGuide;
  DateTime startDate;
  double price;
  bool isAccepted;
  bool paid;
  String description;

  Tour(
      {this.id,
      this.place,
      this.traveler,
      this.tourGuide,
      this.startDate,
      this.price,
      this.isAccepted,
      this.paid,
      this.description});

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
