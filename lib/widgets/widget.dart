import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
PreferredSizeWidget appBarMain(BuildContext context)
{
  return AppBar(
    title: Text("Messaging App"),
    backgroundColor: Color(0xff145C9E),
  );
}

InputDecoration textFieldInputDecoration(String hintText)
{
  return InputDecoration(
      hintText: hintText,
      hintStyle:  TextStyle(
          color: Colors.white54
      ),
      focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}

TextStyle simpleTextStyle()
{
  return  TextStyle(
    color: Colors.white,
  fontSize: 16);
}

