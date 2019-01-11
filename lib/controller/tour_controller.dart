import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nltour_collaborator/model/tour.dart';
import 'package:nltour_collaborator/network/host.dart';

class TourController {
  Future<List<Tour>> getAll() async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .get(Hosting.getAllTours, headers: headers)
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

  Future<Tour> acceptTour(String id, String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'id': id,
      'email': email,
    };

    return await client.put(Hosting.tour, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        return Tour.fromJson(json.decode(response.body));
      }
    });
  }

  Future<bool> registerTour(String tourId, String collaboratorEmail) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'tourId': tourId,
      'collaboratorEmail': collaboratorEmail,
    };
    return await client
        .post(Hosting.registerTour, headers: headers)
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
        .get(Hosting.getWaitingTours, headers: headers)
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

  //TODO get my pending tours (Not tested yet)
  Future<List<Tour>> getPendingTours(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(Hosting.host + "tour/mytours/pending", headers: headers)
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
        .post(Hosting.tour, headers: headers, body: json.encode(tour))
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
        .get(Hosting.getMyTours, headers: headers)
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
}
