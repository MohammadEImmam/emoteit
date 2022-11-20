import 'dart:developer';
import 'package:emoteit/models/emoteit_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'get/get_user.dart';
import 'home.dart';

Future<UserCredential> signup(context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  final newToken = await FirebaseAuth.instance.currentUser?.getIdTokenResult(true);
  log(newToken?.token??"");
  if(newToken?.token == null){
    signup(context);
  }
  try{
    Future<EmoteItUser> user = getUser(newToken?.token??'');
    user.then((value) =>
        Navigator.push(
            context, MaterialPageRoute(
          builder: (context) => HomePage(user: value),)
    ));}
  catch(e){
    print(e);
  }
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
