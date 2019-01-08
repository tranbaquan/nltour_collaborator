// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_registering_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourRegisteringEntity _$TourRegisteringEntityFromJson(
    Map<String, dynamic> json) {
  return TourRegisteringEntity(
      tour: json['tour'] == null
          ? null
          : Tour.fromJson(json['tour'] as Map<String, dynamic>),
      collaborator: json['collaborator'] == null
          ? null
          : Collaborator.fromJson(
              json['collaborator'] as Map<String, dynamic>));
}

Map<String, dynamic> _$TourRegisteringEntityToJson(
        TourRegisteringEntity instance) =>
    <String, dynamic>{
      'tour': instance.tour,
      'collaborator': instance.collaborator
    };
