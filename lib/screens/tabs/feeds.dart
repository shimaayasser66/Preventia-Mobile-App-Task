import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preventia_social_media/models/feed.dart';
import 'package:preventia_social_media/screens/home.dart';
import 'package:preventia_social_media/services/posts.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:preventia_social_media/widgets/feed_card.dart';

class FeedsPage extends StatefulWidget {
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {

  List<Feed> feeds = [];
  bool isLoading = false;

  bool isShowmoreClicked = false;


  final _scaffoldkey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeeds();
  }

  getFeeds() async{

    setState(() {
      isLoading = true;
    });

    Posts posts = Posts();
    feeds = await posts.getPosts();

    setState(() {
      isLoading=false;
    });
  }



  @override
  Widget build(BuildContext context) {

    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    final showmoreBtn= GestureDetector(
      onTap: (){
        isShowmoreClicked=!isShowmoreClicked;
        setState(() {

        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 6,
                    offset: Offset(1.1, 1.2),
                    spreadRadius: 2.0,
                    color: Colors.black12.withOpacity(.5))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 5,bottom: 5),
            child: Text("Show ${!isShowmoreClicked?"more":"less"}"),
          )),

    );


    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
      child: Text(
        "Feed",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );


    showAlertDialog(BuildContext context, int index) {

      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed:  () {
          Navigator.pop(context);
        },
      );
      Widget yesButton = FlatButton(
        child: Text("Yes"),
        onPressed:  () {

          feeds.removeAt(index);
          _scaffoldkey.currentState.showSnackBar(
              SnackBar(content: Text("Post is removed")));
          setState(() {});
          Navigator.pop(context);

        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text("Are you sure that you want to delete this post?"),
        actions: [
          cancelButton,
          yesButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              getFeeds();
            },
                  child: Stack(
                              children: [
                                 !isLoading && feeds != null?Scrollbar(
                                   child: ListView.builder(
                                           shrinkWrap: true,
                                            itemCount: (isShowmoreClicked?feeds.length:
                                            (feeds.length>10?10:feeds.length)),
                                            itemBuilder: (context,index){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: GestureDetector(
                                                      onDoubleTap: (){
                                                        if(isAdmin){
                                                          showAlertDialog(context,index);
                                                        }else{
                                                          _scaffoldkey.currentState.showSnackBar(
                                                              SnackBar(content: Text("You are not the admin")));
                                                        }

                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                                        child: FeedCard(
                                                          feed: feeds[index],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Visibility(
                                                      visible: (isShowmoreClicked&&index==(feeds.length-1))||
                                                      (!isShowmoreClicked&&feeds.length>10&&index==9)
                                                      || (!isShowmoreClicked&&feeds.length<=10&&index==(feeds.length -1)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: showmoreBtn,
                                                      ))

                                                ],
                                              );
                                            },

                                   ),
                                 ):Visibility(
                                    visible: feeds == null,
                                    child: Center(
                                        child: Text("No Posts",
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
                            ),
                ),

          ),



    );
  }
}
