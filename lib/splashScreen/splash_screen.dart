import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users/Assistants/assistant.methods.dart';
import 'package:users/global/golbal.dart';
import 'package:users/screens/login_screen.dart';
import 'package:users/screens/main_page.dart';
import 'package:users/screens/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (firebaseAuth.currentUser != null) {
        // user login ache
        firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo()  : null;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => LoginScreen()),
        );
      } else {
        // user login nei
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => MainScreen()),
        );
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Trippo',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}