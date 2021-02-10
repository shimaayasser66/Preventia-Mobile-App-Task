import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/_routing/router.dart' as router;
import 'package:preventia_social_media/screens/landing.dart';
import 'package:preventia_social_media/screens/login.dart';
import 'package:preventia_social_media/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      onGenerateRoute: router.generateRoute,
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LandingPage(),
    );
  }
}
