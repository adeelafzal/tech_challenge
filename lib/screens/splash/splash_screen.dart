import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/screens/authentication/signin_screen.dart';
import 'package:tech_challenge/screens/home/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(()=>SignInScreen());
      } else {
        Get.off(()=>MainScreen());
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tech Challenge".toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
