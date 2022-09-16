import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();

    Duration duration = const Duration(seconds: 3);

    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            FlutterLogo(size: 200),
            CircularProgressIndicator(
              color: Colors.blue,
            ),
            Text(
              "Made with ❤ in India",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
