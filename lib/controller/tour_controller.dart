import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nltour_collaborator/controller/common.dart';
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/network/tour_url.dart';

class TourController {
  Future<List<Tour>> getAll() async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .get(TourUrl.crud, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }


  Future<bool> registerTour(String tourId, String collaboratorEmail) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'tourId': tourId,
      'email': collaboratorEmail,
    };
    return await client
        .post(TourUrl.collaboratorTour, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return false;
      } else {
        return true;
      }
    });
  }

  Future<List<Tour>> getWaitingTours() async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .get(TourUrl.waiting, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        print(response.body);
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future<List<Tour>> getPendingTours(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(TourUrl.collaboratorPending, headers: headers)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future<Tour> createTour(Tour tour) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(TourUrl.crud, headers: headers, body: json.encode(tour))
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        return Tour.fromJson(json.decode(response.body));
      }
    });
  }

  Future<List<Tour>> getMyTour(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(TourUrl.collaboratorTour, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future cancelRegisterTour(Tour tour) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'tourId': tour.id,
      'email': tour.tourGuide.email,
    };
    return await client.delete(TourUrl.registering, headers: headers);
  }
}
