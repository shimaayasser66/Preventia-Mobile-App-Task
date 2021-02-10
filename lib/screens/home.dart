import 'package:flutter/material.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:preventia_social_media/screens/tabs/search.dart';
import 'package:preventia_social_media/screens/tabs/feeds.dart';
import 'package:preventia_social_media/screens/tabs/newpost.dart';
import 'package:preventia_social_media/screens/tabs/settings.dart';
import 'package:line_icons/line_icons.dart';


String userToken;
String userName;
bool isAdmin = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BuildContext scaffoldContext;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  final List<Widget> _pages = [
    FeedsPage(),
    SearchPage(),
    NewPostPage(),
    SettingsPage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scaffoldkey.currentState.showSnackBar(
        SnackBar(content: Text("Hello ${userName}"))));
  }

  @override
  Widget build(BuildContext context) {

    final bottomNavBar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.6),
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed),
          title: Text(
            'Feed',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.search),
          title: Text(
            'Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text(
            'New Post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

    return Scaffold(
      key: _scaffoldkey,
      bottomNavigationBar: bottomNavBar,
      body: _pages[_currentIndex],
    );
  }

}
