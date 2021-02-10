import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/models/feed.dart';
import 'package:intl/intl.dart';
import 'package:preventia_social_media/utils/colors.dart';

class FeedCard extends StatefulWidget {
  final Feed feed;
  FeedCard({Key key, this.feed}) : super(key: key);
  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {

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

    var dateValue = new DateFormat("yyyy-MM-ddTHH:mm:ssZ").
    parseUTC(widget.feed.publishDate).toLocal();

    String formattedPublishDate = DateFormat("dd-MM-yyyy  hh:mm a").format(dateValue);


    final feedImage = Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, userDetailsViewRoute,
            arguments: widget.feed.owner.id),
        child: Hero(
          tag: widget.feed.image,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(14.0),
            child: Stack(
              children: [
                Align(
                  // top: height/10,
                  // left: width/2.5,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: height/10),
                    child: SpinKitRing(
                      color: Colors.black45,
                      size: 50.0,
                    ),
                  ),
                ),
                Container(
                  height: height/4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.feed.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Align(
                  // top: height/10,
                  // left: width/2.5,
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: height/4.6,left: width/2),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.7),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.feed.likes}",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(width: 3,),
                          Icon(Icons.favorite_border,color: Colors.red[800],),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final postDate = Text(
      formattedPublishDate,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );

    final userName = Text(
      widget.feed.owner.firstName+" "+widget.feed.owner.lastName,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );

    final descriptionText = Container(
      child: Text(
        widget.feed.text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
        ),
      ),
    );

    final userImage =  CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 15,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: DecorationImage(
            image: NetworkImage(widget.feed.owner.picture),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );


    final tags = Wrap(
      runSpacing: 2.0,
      spacing: 10.0,
      children: widget.feed.tags.map<Widget>((tag){
        return Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primaryDark,width: 1),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)  //                 <--- border radius here
              ),),
          child: Padding(
            padding: const EdgeInsets.only(top: 3,bottom: 3,left: 10,right: 10),
            child: Text(tag,style: TextStyle(color: primaryDark),),
          ),
        );
      }).toList(),
    );

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right:5.0),
              child: postDate,
            )),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              userImage,
              SizedBox(width: 10,),
              userName,
            ],
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 15,left: 5,right: 5),
              child: descriptionText,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tags,
        ),
        feedImage
      ],
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 5.0, left: 0.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: cardContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
