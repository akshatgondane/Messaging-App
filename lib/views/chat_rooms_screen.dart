import 'package:flutter/material.dart';
import 'package:messaging_app/helper/authenticate.dart';
import 'package:messaging_app/services/auth.dart';
import 'package:messaging_app/views/search.dart';

// ignore_for_file: prefer_const_constructors
class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      appBar: AppBar(
        title: new Text("Messaging App"),
        backgroundColor: Color(0xff145C9E),
        actions: [
          GestureDetector(
            onTap: ()
            {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
