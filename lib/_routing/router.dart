import 'package:flutter/material.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/screens/home.dart';
import 'package:preventia_social_media/screens/landing.dart';
import 'package:preventia_social_media/screens/login.dart';
import 'package:preventia_social_media/screens/register.dart';
import 'package:preventia_social_media/screens/userfeeds.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case userPostsRoute:
      return MaterialPageRoute(builder: (context) => UserFeedsPage(user: settings.arguments,));
      break;
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
