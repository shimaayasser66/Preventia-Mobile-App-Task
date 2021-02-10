import 'package:preventia_social_media/models/user.dart';
import 'package:preventia_social_media/utils/utils.dart';


class Feed {
  int likes;
  String publishDate;
  List<dynamic> tags;
  User owner;
  String image;
  String link, text;

  Feed({this.likes,this.publishDate,this.text,this.image,this.link,this.owner,this.tags});

  factory Feed.fromJson(Map<String, dynamic> json) {
    {
      return Feed(

           likes:json["likes"],
           publishDate: json["publishDate"],
           text: json["text"],
           owner: User.fromJson(json["owner"]),
           image: json["image"],
           link: json["link"],
           tags: json['tags'].toList(),


      );
    }
  }

}

// class Tag{
//
//   String title;
//
//   Tag({this.title});
//
//   factory Tag.fromJson(Map<String, dynamic> json) {
//     {
//       return Tag(
//
//           title:json["title"],
//
//       );
//     }
//   }
//
// }

