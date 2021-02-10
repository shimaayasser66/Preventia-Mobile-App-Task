import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/models/user.dart';
import 'package:preventia_social_media/services/users.dart';
import 'package:preventia_social_media/utils/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<User> users = [];
  bool isLoading = false;

  String searchText="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  getUsers() async{

    setState(() {
      isLoading = true;
    });

    Users usersList = Users();
    users = await usersList.getUsers();

    setState(() {
      isLoading=false;
    });
  }



  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
      child: Text(
        "Chats",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    final searchBar = Container(
      height: 50.0,
      width: width/1.5,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        onChanged: (val){
          searchText=val;
          setState(() {

          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(top: 15.0),
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    final onlineUsersHeading = Text(
      "ONLINE USERS",
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
    );

    final listOfOnlineUsers = Stack(
      children: [
      !isLoading && users != null?
      Scrollbar(
        child: ListView(
          shrinkWrap: true,
          children: users.map((user)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildUserCard(user, context),
          )).toList(),
        ),
      ):Visibility(
        visible: users == null,
        child: Center(
            child: Text("No Users",
              style: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold),)),

      ),
        Visibility(
          visible: isLoading,
          child: Center(
            child: SpinKitRing(
              color: Colors.black45,
              size: 150.0,
            ),
          ),
        )
      ],
    );

    final onlineUsers = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          onlineUsersHeading,
          SizedBox(
            height: 10.0,
          ),
          //listOfOnlineUsers
        ],
      ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        title: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: searchBar),
        leading: Text(""),
      ),
      body: SafeArea(
        child:  RefreshIndicator(
          onRefresh: () async {
            getUsers();
          },
          child:Padding(
                    padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0),
                    child: listOfOnlineUsers

                  )
              ),
            ),
    );
  }

  Widget _buildUserCard(User user, BuildContext context) {

    final fullName = user.firstName+user.lastName;
    
    final onlineTag = Positioned(
      bottom: 10.0,
      right: 3.0,
      child: Container(
        height: 15.0,
        width: 15.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          color: Colors.lightGreen,
        ),
      ),
    );
    return Visibility(
      visible: fullName.toLowerCase().contains(searchText.toLowerCase()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
              onTap: () => Navigator.pushNamed(context, userPostsRoute, arguments: user),
              leading:Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8.0),
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.picture),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    onlineTag
                  ],
                ),
              title:Text(
                user.firstName + " " + user.lastName,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
             subtitle: Text(
               user.email,
               style: TextStyle(fontWeight: FontWeight.w600),
             ),

          ),
        ),
      ),
    );
  }



}
