import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:preventia_social_media/screens/home.dart';

class Auth{

  String baseUrl = "https://reqres.in/api/";
  String error = "";

  Future<bool> loginUser(mail,password) async {

    try{
      String loginUrl = "${baseUrl}login";
      var data = {
        'email': mail,
        'password': password,
      };

      final response = await http.post(loginUrl, body: data);
      print(response.statusCode);

      if(response.statusCode == 200) {
        userToken = json.decode(response.body)["token"];
        userName = mail.toString().split("@")[0];
        return true;
      }else{
        error = json.decode(response.body)["error"];
        return false;
      }

    }catch(e){
      print(e);
      error = e.toString();
      return false;
    }

  }




}



