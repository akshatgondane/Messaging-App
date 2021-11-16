import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/widgets/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50.0,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("email"),
              ),

              TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("password")
              ),

              const SizedBox(height: 8,),

              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Forgot Password?", style: simpleTextStyle()),
                ),
              ),

              const SizedBox(height: 8,),

              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xff007EF4),
                          Color(0xff2A75BC)
                        ]
                    ),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: const Text("Sign In", style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                ),),
              ),

              const SizedBox(height: 16,),

              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: const Text("Sign In with Google", style: TextStyle(
                    color: Colors.black,
                    fontSize: 17
                ),),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account? ", style: new TextStyle(color: Colors.white, fontSize: 16)),
                  Text("Register Now", style: new TextStyle(
                      color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),)
                ],
              ),

              const SizedBox(height: 50)

            ],
          ),
        ),
      )
    );
  }
}
