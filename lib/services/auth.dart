// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/modal/user.dart';

class AuthMethods
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserClass? _userFromFireBase(User user)
  {
    return user != null ? UserClass(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async
  {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFireBase(firebaseUser!);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async
  {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFireBase(firebaseUser!);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future resetPass(String email) async
  {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future signOut() async
  {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}