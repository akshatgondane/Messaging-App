import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/helper/helperfunctions.dart';
import 'package:messaging_app/services/auth.dart';
import 'package:messaging_app/services/database.dart';
import 'package:messaging_app/widgets/widget.dart';

import 'chat_rooms_screen.dart';
// ignore_for_file: prefer_const_constructors
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthMethods authService = AuthMethods();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
          emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot;
          DatabaseMethods().getUserInfo(emailEditingController.text).then((val){
            userInfoSnapshot=val;
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserNameSharedPreference(
                userInfoSnapshot.docs[0].get("name"));
            HelperFunctions.saveUserEmailSharedPreference(
                userInfoSnapshot.docs[0].get("email"));
          });


          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50.0,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                        ? null
                        : "Please Enter Correct Email";
                  },
                  controller: emailEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("email"),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val!.length > 6
                        ? null
                        : "Enter Password 6+ characters";
                  },
                  style: simpleTextStyle(),
                  controller: passwordEditingController,
                  decoration: textFieldInputDecoration("password"),
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

                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
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
                    Text("Don't have account? ", style: TextStyle(color: Colors.white, fontSize: 16)),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register Now", style: TextStyle(
                            color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),)
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 50)

              ],
            ),
          ),
        ),
      )
    );
  }
}
