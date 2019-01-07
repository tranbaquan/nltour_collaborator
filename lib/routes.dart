import 'package:flutter/material.dart';
import 'package:nltour_collaborator/ui/change_pass_page.dart';
import 'package:nltour_collaborator/ui/forgot_page.dart';
import 'package:nltour_collaborator/ui/histoy_page.dart';
import 'package:nltour_collaborator/ui/home_page.dart';
import 'package:nltour_collaborator/ui/info_page.dart';
import 'package:nltour_collaborator/ui/login_page.dart';
import 'package:nltour_collaborator/ui/mesage_page.dart';
import 'package:nltour_collaborator/ui/payment_page.dart';
import 'package:nltour_collaborator/ui/place_page.dart';

final routes = {
  '/': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomeCollaboratorPage(),
  '/forgot': (BuildContext context) => new ForgotPage(),
  '/changepass': (BuildContext context) => new ChangePassPage(),
  '/place': (BuildContext context) => new PlacePage(),
  '/payment': (BuildContext context) => new PaymentPage(),
  '/history': (BuildContext context) => new HistoryPage(),
  '/info': (BuildContext context) => new InformationPage(),
  '/message': (BuildContext context) => new MessagePage(),
};
