import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/otp.dart';
import 'package:nltour_collaborator/network/host.dart';

class CollaboratorController {
  Future<Collaborator> login(Collaborator collaborator) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.collaboratorLogin,
        body: json.encode(collaborator), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  //TODO if there is no register for collaborator, delete this method
  Future<Collaborator> create(Collaborator collaborator) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(
        Hosting.collaborator, body: json.encode(collaborator), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Collaborator> update(Collaborator collaborator) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .put(Hosting.collaboratorUpdateInfo, body: json.encode(collaborator),
        headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Collaborator> getCollaborator(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(Hosting.collaborator, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  Future<OTP> getOTP(String email, String requestType) {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'requestType': requestType,
    };
    return client.get(Hosting.getOTP, headers: headers).then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return OTP.fromJson(json.decode(response.body));
      }
    });
  }

  Future<bool> validateOTP(OTP otp) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.getOTP, body: json.encode(otp), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return false;
      } else {
        return response.body == 'true' ? true : false;
      }
    });
  }

  Future<Collaborator> changePassword(String email, String newPassword,
      String identifier) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'newPassword': newPassword,
      'identifier': identifier,
    };

    return await client
        .put(Hosting.changePass, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  //TODO continue here
  Future<Collaborator> findByEmail(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'email': email,
    };

    return await client
        .get(Hosting.collaborator, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        print(response.statusCode);
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }
}
