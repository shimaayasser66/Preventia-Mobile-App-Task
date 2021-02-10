import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/models/user.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:line_icons/line_icons.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {




  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    final logoutBtn = Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.transparent,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pushNamed(context, loginViewRoute),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'LOG OUT',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
      ),
    );

    return Scaffold(
      body:  Column(
                children: <Widget>[
                      Container(
                        width: width,
                        height: 250.0,
                        decoration: BoxDecoration(gradient: primaryGradient),
                        child: Icon(Icons.exit_to_app,color: Colors.white,size: 100,),
                      ),

                     logoutBtn
                ],
              ),

    );
  }


}
