import 'package:preventia_social_media/utils/utils.dart';


class User {
  String id;
  String firstName,lastName,gender,email;
  String dateOfBirth;
  String picture;
  int age;

  User({this.id, this.firstName, this.email, this.dateOfBirth, this.lastName, this.picture, this.gender, this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    {
      return User(

          id:json["id"],
          firstName: json["firstName"],
          email: json["email"],
          dateOfBirth: json["dateOfBirth"],
          lastName: json["lastName"],
          picture: json["picture"],
          gender: json["gender"],


      );
    }
  }
}


