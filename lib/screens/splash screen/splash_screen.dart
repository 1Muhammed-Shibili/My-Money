import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: TextStyle(
                  fontSize: 85,
                  color: Colors.white,
                  fontFamily: 'DancingScript'),
              r"$",
            ),
            SizedBox(height: 20),
            Text(
              'My Money',
              style: TextStyle(
                fontFamily: 'LuckiestGuy',
                fontSize: 48,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
