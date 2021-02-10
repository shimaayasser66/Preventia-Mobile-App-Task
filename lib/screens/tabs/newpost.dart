import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preventia_social_media/screens/tabs/feeds.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:preventia_social_media/utils/utils.dart';
import 'package:preventia_social_media/widgets/show_image.dart';

List<File> imageFiles = [];
List<Show_Image> show_Image =[];

class NewPostPage extends StatefulWidget {

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController _descriptionController = TextEditingController();

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  bool isAddClicked = false;

  File file;


  @override
  Widget build(BuildContext context) {



    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    handleTakePhoto() async{

      Navigator.pop(context);
      // ignore: deprecated_member_use
      File file = await ImagePicker.pickImage(source: ImageSource.camera
          ,maxHeight: 675
          ,maxWidth: 960);

      if(file !=null) {


        setState(() {

          this.file = file;
          Show_Image show_image = Show_Image(file);
          show_Image.add(show_image);
          imageFiles.add(file);

        });


      }


    }

    handleChooseFromGallery() async{

      Navigator.pop(context);

      // ignore: deprecated_member_use
      File file = await ImagePicker.pickImage(source: ImageSource.gallery);

      if(file !=null) {
        setState(() {
          this.file = file;
          Show_Image show_image = Show_Image(file);
          show_Image.add(show_image);
          imageFiles.add(file);


        });
      }

    }

    SelectImage(parentContext){

      print(imageFiles.length<11);

      return showDialog(context: parentContext ,

          builder: (parentContext){

            return SimpleDialog(

              title: Text("Add Image"),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text("Photo with Camera"),
                  onPressed: handleTakePhoto,
                ),
                SimpleDialogOption(
                  child: Text("Image from Gallery"),
                  onPressed: handleChooseFromGallery,
                ),
                SimpleDialogOption(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(parentContext),
                )
              ],

            );

          });


    }

    final pageTitle = Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        "New Post",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );


    final description = Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.4), offset: Offset(.5, 1.2),spreadRadius: 2,blurRadius: 2),
        ],borderRadius: BorderRadius.all(Radius.circular(15))),
        width: MediaQuery.of(context).size.width/1.1,
        height: height/5,
        child:TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            //labelText: 'Description',
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.description,
              color: Colors.black45,
            ),
            hintText: 'Description',
          ),
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.black,
        )
    );


    final addImage = Padding(
      padding: const EdgeInsets.only(right:10.0),
      child: Container(
        height: 120.0,

        width: MediaQuery.of(context).size.width,
        child:IconButton(

          icon:Icon(Icons.add,size: 80,color: Colors.black87,),

          onPressed: ()=> imageFiles.length<10 ? SelectImage(context)
              :showSnackBar("Oops, you've reached the photos limit ( 10 )",false),

        ),
        decoration: new BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: Colors.white,
              width: 5.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)  //                 <--- border radius here
          ),


        ),
      ),

    );


    final showImages = Container(
      width: width,
      child: Wrap(
        children: show_Image,
      ),
    );

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: primaryDark,
        elevation: 0,
        centerTitle: true,
        title: pageTitle,
        leading: Text(""),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                if(_descriptionController.text.trim().isEmpty){
                  showSnackBar("Description is empty",false);
                }else if(imageFiles.length==0){
                  showSnackBar("You need to upload at least one image",false);
                }else {
                  imageFiles.clear();
                  show_Image.clear();
                  _descriptionController.clear();
                  setState(() {

                  });
                  showSnackBar("Post created",true);

                  //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FeedsPage(),));

                }
              },
              child:Text("Add",
                style: TextStyle(color: Colors.white, fontSize: 15,
                    fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 70.0,
          left: 30.0,
          right: 30.0,
          bottom: 30.0,
        ),
        height: height,
        width: width,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
                addImage,
                SizedBox(height: 10,),
                showImages,
                SizedBox(height: 20,),
                description
                // image,
                // notificationHeader,
                // notificationText
              ],
            ),

      ),
    );
  }

  showSnackBar(text,bool isSuccessful){

    SnackBar snackBar = SnackBar(
      elevation: 6.0,
      backgroundColor: isSuccessful?Colors.black87:Colors.red[800],
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);

  }
}
