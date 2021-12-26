import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/helper/constants.dart';
import 'package:messaging_app/services/database.dart';
import 'package:messaging_app/widgets/widget.dart';

import 'chat.dart';

// ignore_for_file: prefer_const_constructors
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot? searchSnapshot;

  initiateSearch()
  {
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val)
    {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList()
  {

    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot!.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index)
      {
        return SearchTile(
            searchSnapshot!.docs[index].get("name").toString(),
            searchSnapshot!.docs[index].get("email").toString());
      },
    ) :  Container();
  }
  Widget SearchTile(String userName,String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextStyle(),),
              Text(userEmail, style: simpleTextStyle(),)

            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              sendMessage(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }
  sendMessage(String userName){
    List<String> users = [Constants.myName,userName];

    String chatRoomId = getChatRoomId(Constants.myName,userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(
          chatRoomId: chatRoomId,
        )
    ));

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      backgroundColor: Color(0xff1F1F1F),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                          style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: "search username...",
                          hintStyle: TextStyle(
                            color: Colors.white54
                          ),
                          border: InputBorder.none,
                        )
                  )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              colors: const [
                                Color(0x36FFFFFF),
                                Color(0x0FFFFFFF)
                              ]
                          )
                      ),
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        )
      ),
    );
  }
}





