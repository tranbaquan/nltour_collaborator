import 'package:json_annotation/json_annotation.dart';
import 'package:nltour_collaborator/model/address.dart';
import 'package:nltour_collaborator/model/languages.dart';
import 'package:nltour_collaborator/model/type.dart';

part 'collaborator.g.dart';

@JsonSerializable()
class Collaborator {
  String firstName;
  String lastName;
  String personalID;
  String email;
  Gender gender;
  String avatar;
  DateTime dob;
  Address address;
  Languages languages;
  String password;
  DateTime activeDate;
  TourGuideType type;
  String phoneNumber;

  Collaborator(
      {this.firstName,
      this.lastName,
      this.personalID,
      this.email,
      this.gender,
      this.avatar,
      this.dob,
      this.address,
      this.languages,
      this.password,
      this.activeDate,
      this.type,
      this.phoneNumber});

  factory Collaborator.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorFromJson(json);

  Map<String, dynamic> toJson() => _$CollaboratorToJson(this);

  Map<String, String> toDBMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "personal_id": personalID,
      "email": email,
      "gender": "${gender.index}",
      "avatar": avatar,
      "phone_number": phoneNumber,
      "dob": dob.toIso8601String(),
      "country": address.country,
      "main_language": languages.primaryLanguage,
    };
  }

  factory Collaborator.fromDBMap(Map<String, dynamic> map) {
    return Collaborator(
        firstName: map['first_name'] as String,
        lastName: map['last_name'] as String,
        personalID: map['personal_id'] as String,
        email: map['email'] as String,
        gender: getGender(map['gender'] as int),
        avatar: map['avatar'],
        dob: map['dob'] == null ? null : DateTime.parse(map['dob'] as String),
        address: Address(country: map['country'] as String),
        languages: Languages(primaryLanguage: map['main_language'] as String),
        phoneNumber: map['phone_number'] as String);
  }

  static Gender getGender(int genderIndex) {
    switch (genderIndex) {
      case 0:
        return Gender.MALE;
      case 1:
        return Gender.FEMALE;
      default:
        return Gender.MALE;
    }
  }
}
