import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preventia_social_media/app.dart';
import 'package:preventia_social_media/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  runApp(App());
}
