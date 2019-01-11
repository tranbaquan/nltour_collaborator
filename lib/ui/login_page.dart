import 'package:flutter/material.dart';
import 'package:nltour_collaborator/controller/collaborator_controller.dart';
import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:nltour_collaborator/supporter/auth.dart';
import 'package:nltour_collaborator/supporter/validator.dart';
import 'package:nltour_collaborator/ui/widget/nl_button.dart';
import 'package:nltour_collaborator/ui/widget/nl_form.dart';
import 'package:nltour_collaborator/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  var authStateProvider = new AuthStateProvider();

  @override
  void initState() {
    check();
    super.initState();
  }

  Future check() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogged = prefs.get('logged');
    if (isLogged != null && isLogged) {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildBackground(context),
              buildLoginForm(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional(0, 2),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/nltour-2018.appspot.com/o/travel.jpg?alt=media&token=1effd6f7-0ac3-4b68-b758-48c4bcf71465',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              height: 240,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/nltour-2018.appspot.com/o/NLGuide.png?alt=media&token=180bd4aa-6922-42fe-8ec6-c409f160eab6',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    final usernameInput = TextInputForm(
      hintText: 'USERNAME',
      validator: Validator.validateEmail,
      controller: _email,
      keyboardType: TextInputType.emailAddress,
    );

    final passwordInput = TextInputForm(
      obscureText: true,
      hintText: 'PASSWORD',
      controller: _password,
      validator: Validator.validatePassword,
    );

    final forgotPasswordButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/forgot");
        },
        child: Text(
          'FORGOT PASSWORD',
          style: TextStyle(
            color: Color(0xFF008fe5),
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );

    final loginButton = RaisedGradientRoundedButton(
      child: Text(
        'LOGIN',
        style: TextStyle(color: Colors.white),
      ),
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      onPressed: () {
        if (_formKey.currentState.validate()) {
            NLDialog.showLoading(context);
            _login();

        }
      },
    );

    final loginForm = Container(
      padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10.0),
            child: usernameInput,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10.0),
            child: passwordInput,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: forgotPasswordButton,
          ),
          loginButton,
        ],
      ),
    );
    return Form(
      key: _formKey,
      child: loginForm,
      autovalidate: true,
    );
  }

  _login() async {
    final Collaborator collaborator =
    Collaborator(email: _email.text, password: _password.text);
    var controller = CollaboratorController();
    controller.login(collaborator).then((data) {
      Navigator.of(context).pop();
      if (data != null) {
        _saveUser(data);
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        NLDialog.showInfo(context, 'Login Failed', 'Email or password is incorrect!');
      }
    });
  }

  void _saveUser(Collaborator data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', true);
    prefs.setString('email', data.email);
    prefs.setString('avatar', data.avatar);
    prefs.setString('firstName', data.firstName);
    prefs.setString('lastName', data.lastName);
  }
}
