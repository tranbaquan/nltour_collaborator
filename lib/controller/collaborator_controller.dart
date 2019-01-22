import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/model/otp.dart';
import 'package:nltour_collaborator/network/collaborator_url.dart';
import 'package:nltour_collaborator/network/host.dart';

class CollaboratorController {
  Future<Collaborator> login(Collaborator collaborator) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(CollaboratorUrl.login,
        body: json.encode(collaborator), headers: headers)
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
        .put(CollaboratorUrl.crud,
        body: json.encode(collaborator), headers: headers)
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
        .get(CollaboratorUrl, headers: headers)
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
    return client.get(CollaboratorUrl.otp, headers: headers).then((response) {
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
        .post(CollaboratorUrl.otp, body: json.encode(otp), headers: headers)
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
        .put(CollaboratorUrl.otp, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Collaborator> findByEmail(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'email': email,
    };

    return await client
        .get(CollaboratorUrl.crud, headers: headers)
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
