

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:preventia_social_media/screens/tabs/newpost.dart';

class Show_Image extends StatefulWidget {

  File file;
  bool deletedfile = false;

  Show_Image(this.file);

  @override
  _Show_ImageState createState() => _Show_ImageState();

}

builderupdateImage(File file){

  if(file != null) {
    return GestureDetector(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(file),
            )
        ),

      ),
    );
  }else{

    return Text("");


  }

}





class _Show_ImageState extends State<Show_Image> {


  @override
  Widget build(BuildContext context) {

    File updatedfile = widget.file;


    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        child:  !widget.deletedfile ? Container(
          height: 100.0,
          width: 100,
          decoration: new BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: Colors.white,
                width: 0.0
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)  //                 <--- border radius here
            ),



          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top : 10.0),
              child: GestureDetector(

                child: Stack(children: <Widget>[

                  !widget.deletedfile ?builderupdateImage(widget.file):Text(""),

                  !widget.deletedfile ? IconButton(
                    icon: Icon(Icons.delete,color: Colors.white ,size: 30.0,),
                    onPressed: (){

                      setState(() {

                        widget.deletedfile = true;
                        imageFiles.remove(widget.file);
                        show_Image.remove(widget.file);
                        widget.file = null;



                      });
                    },

                  ):Text(""),
                ],
                ),
              ),
            ),
          ),
        )
            :Text(""),
      ),
    );
  }
}
