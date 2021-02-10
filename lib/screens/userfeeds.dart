import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preventia_social_media/models/feed.dart';
import 'package:preventia_social_media/models/user.dart';
import 'package:preventia_social_media/screens/home.dart';
import 'package:preventia_social_media/services/posts.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:preventia_social_media/widgets/feed_card.dart';

class UserFeedsPage extends StatefulWidget {
  
  final User user;

  const UserFeedsPage({Key key, this.user}) : super(key: key);
  
  @override
  _UserFeedsPageState createState() => _UserFeedsPageState();
}

class _UserFeedsPageState extends State<UserFeedsPage> {

  List<Feed> feeds = [];
  bool isLoading = false;

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
    feeds = await posts.getUserPosts(widget.user.id);

    setState(() {
      isLoading=false;
    });
  }


  @override
  Widget build(BuildContext context) {

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

    final userImage =  CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 30,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: DecorationImage(
            image: NetworkImage(widget.user.picture),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: primaryDark,
        elevation: 0,
        toolbarHeight: 120,
        centerTitle: true,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: userImage,
            ),
            Text(widget.user.firstName+" "+widget.user.lastName),
          ],
        ),

      ),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              getFeeds();
            },
            child: Stack(
                        children: [
                           !isLoading && feeds != null?ListView.builder(
                              itemCount:feeds.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                    onDoubleTap: (){
                                      if(isAdmin){
                                        feeds.removeAt(index);
                                        _scaffoldkey.currentState.showSnackBar(
                                            SnackBar(content: Text("Post is removed")));
                                        setState(() {});
                                      }else{
                                        _scaffoldkey.currentState.showSnackBar(
                                            SnackBar(content: Text("You are not the admin")));
                                      }

                                    },
                                    child: FeedCard(
                                      feed: feeds[index],
                                    ),
                                  ),
                                );
                              },

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
                      )

                  ),
          ),



    );
  }
}
