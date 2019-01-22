import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/supporter/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionChecker {
  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLogged = prefs.getBool('logged');

    if (isLogged != null && isLogged) {
      return true;
    }

    return false;
  }
}

class SessionSupporter {
  static Future<Collaborator> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    return DatabaseProvider.db.getCollaborator(email);
  }
}