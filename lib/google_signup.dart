import 'dart:developer';
import 'package:emoteit/cubits/emortion/emortion_cubit.dart';
import 'package:emoteit/models/emoteit_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'get/get_feed.dart';
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
  if(newToken?.token == null){
    signup(context);
  }
  try{

    Future<EmoteItUser> user = getUser(newToken?.token??'');
    log(newToken?.token??'');
    user.then((value) =>
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<EmortionCubit>(
                create: (context) => EmortionCubit('1', newToken?.token??'', Feed()),
                child: HomePage(user: value),
              );
            },
          ),
        )
  );

  }
  catch(e){
    print(e);
  }
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
