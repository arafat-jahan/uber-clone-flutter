import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users/global/golbal.dart';
import 'package:users/models/user_model.dart';

class AssistantMethods {
  static void readCurrentOnlineUserInfo() async {
    currnetUser = firebaseAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currnetUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}
