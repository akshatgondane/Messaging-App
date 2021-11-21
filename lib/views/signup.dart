import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth.dart';
import 'package:messaging_app/services/database.dart';
import 'package:messaging_app/views/chat_rooms_screen.dart';
import 'package:messaging_app/widgets/widget.dart';

// ignore_for_file: prefer_const_constructors
class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  signMeUP()
  {
    if(formKey.currentState!.validate())
      {
        Map<String, String> userInfoMap = {
          "name": usernameTextEditingController.text,
          "email": emailTextEditingController.text
        };

        setState(() {
          isLoading = true;
        });
        authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
            passwordTextEditingController.text).then((val) {

              databaseMethods.uploadUserInfo(userInfoMap);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()) );
        });

      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        backgroundColor: Color(0xff1F1F1F),
        body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator(),),
        ) : SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50.0,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                      children: [
                        TextFormField(
                          validator: (val)
                          {
                            return val!.isEmpty || val.length < 2 ? "Please provide a valid username" : null;
                          },
                          controller: usernameTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("username"),
                        ),

                        TextFormField(
                          validator: (val)
                          {
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Please provide a valid email ID";
                          },
                          controller: emailTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("email"),
                        ),

                        TextFormField(
                          validator: (val)
                            {
                              return val!.length > 6 ? null : "Please provide a password of 6+ characters";
                            },
                            obscureText: true,
                            controller: passwordTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("password")
                        ),
                      ],

                    ),
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
                  onTap: ()
                  {
                    //TODO
                    signMeUP();
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
                    child: const Text("Sign Up", style: TextStyle(
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
                  child: const Text("Sign Up with Google", style: TextStyle(
                      color: Colors.black,
                      fontSize: 17
                  ),),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(color: Colors.white, fontSize: 16)),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("SignIn Now", style: TextStyle(
                            color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),)
                      ),
                    )
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
