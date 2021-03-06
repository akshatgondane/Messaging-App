import 'package:flutter/material.dart';
import 'package:messaging_app/views/signin.dart';
import 'package:messaging_app/views/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView()
  {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
        return SignIn(toggleView);
    }
    else {
        return SignUp(toggleView);
    }
  }
}
