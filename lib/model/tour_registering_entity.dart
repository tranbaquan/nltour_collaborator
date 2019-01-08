import 'package:json_annotation/json_annotation.dart';
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/tour.dart';

part 'tour_registering_entity.g.dart';

@JsonSerializable()
class TourRegisteringEntity {
  Tour tour;
  Collaborator collaborator;

  TourRegisteringEntity({this.tour, this.collaborator});

  factory TourRegisteringEntity.fromJson(Map<String, dynamic> json) =>
      _$TourRegisteringEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TourRegisteringEntityToJson(this);
}
