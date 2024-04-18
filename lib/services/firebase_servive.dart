import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._interal();
  factory FirebaseService() => _singleton;
  FirebaseService._interal();

  final auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }

  onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      print(e);
    }
  }

  onRegister(
      {required String email,
      required String password,
      required String name,
      required String userName,
      required String userCity,
      bool organiser = false,
      String organiserName = '',
      List<String> myEvents = const [],
      List<String> connections = const []}) async {
    try {
      // Check if the username is already taken
      bool isUserNameTaken = await isUserNameAlreadyTaken(userName);
      if (isUserNameTaken) {
        Fluttertoast.showToast(
            msg: 'Username is already taken by another user',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: const Color(0xffe7d9ff),
            textColor: const Color(0xbf000000),
            fontSize: 16.0);
        // Handle the case where the username is already taken
        print('Username is already taken');
        return;
      }

      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(credential);
      final user = credential.user;
      Map<String, dynamic> userData = {
        'name': name,
        'userName': userName,
        'userCity': userCity,
        'organiser': organiser,
        'organiserName': organiserName,
        'myEvents': myEvents,
        'connections': connections,
      };

      // Store additional user data in Firestore
      await _db.collection('users').doc(user!.uid).set(userData);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'Email is already in use by another user',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: const Color(0xffe7d9ff),
            textColor: const Color(0xbf000000),
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isUserNameAlreadyTaken(String userName) async {
    // Query Firestore to check if the username already exists
    final querySnapshot = await _db
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();

    // If there are any documents returned, it means the username is already taken
    return querySnapshot.docs.isNotEmpty;
  }

  logOut() async {
    await auth.signOut();
    currentUser = null;
  }
}
