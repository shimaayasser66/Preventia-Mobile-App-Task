import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:preventia_social_media/models/feed.dart';
import 'package:preventia_social_media/screens/home.dart';

class Posts{

  String baseUrl = "https://dummyapi.io/data/api/";
  String error = "";
  String appId = "6021ba4e390e6b72e9a2fdf2";

  Future<List<Feed>> getPosts() async {

    try{
      String postsUrl = "${baseUrl}post";
      final response = await http.get(postsUrl,headers: {"app-id":appId});
      print(response.statusCode);

      if(response.statusCode == 200) {
        List parsed=json.decode(response.body)["data"];
        return parsed.map((e) => Feed.fromJson(e)).toList();
      }

    }catch(e){
      print(e);
      error = e.toString();
    }

  }


  Future<List<Feed>> getUserPosts(String userId) async {

    try{
      String postsUrl = "${baseUrl}user/${userId}/post";
      final response = await http.get(postsUrl,headers: {"app-id":appId});
      print(response.statusCode);

      if(response.statusCode == 200) {
        List parsed=json.decode(response.body)["data"];
        return parsed.map((e) => Feed.fromJson(e)).toList();
      }

    }catch(e){
      print(e);
      error = e.toString();
    }

  }




}



