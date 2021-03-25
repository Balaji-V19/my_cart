import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FirebaseSettings{

  FirebaseAuth mauth=FirebaseAuth.instance;


  Future<bool> signup(String email,String pswd) async{
    try{
      var res=await mauth.createUserWithEmailAndPassword(email: email, password: pswd);
      User user=res.user;
      var id=user.uid;
      print('here is the user id $id');
      if(user!=null){
        return true;
      }
      else{
        return false;
      }

    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> signin(String email,String pswd) async{
    try{
      var res=await mauth.signInWithEmailAndPassword(email: email, password: pswd);
      User user=res.user;
      var id=user.uid;
      print('here is the user id $id');
      if(user!=null){
        return true;
      }
      else{
        return false;
      }

    }catch(e){
      print(e);
      return false;
    }
  }

  Future signout() async{
    try{
      await mauth.signOut();
    }catch(e){
      print(e);
    }


  }

}