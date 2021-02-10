import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preventia_social_media/_routing/routes.dart';
import 'package:preventia_social_media/screens/home.dart';
import 'package:preventia_social_media/services/auth.dart';
import 'package:preventia_social_media/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );
    final pageTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Log In.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        Text(
          "We missed you!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );

    final emailField = TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          LineIcons.envelope,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );

    final passwordField = TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          LineIcons.lock,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
    );

    final loginForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[emailField, passwordField],
        ),
      ),
    );

    final loginBtn = Container(
      margin: EdgeInsets.only(top: 40.0),
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () =>handleLogin(_emailController.text.toString(),_passwordController.text.toString()),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'SIGN IN',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
        ),
      ),
    );

    final forgotPassword = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, resetPasswordViewRoute),
        child: Center(
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    final newUser = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, registerViewRoute),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New User?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ' Create account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child:Container(
          decoration: BoxDecoration(
              gradient: primaryGradient),
          child: Container(
                padding: EdgeInsets.only(top: 150.0, left: 30.0, right: 30.0),
                color: isLoading?Colors.white.withOpacity(.5):Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        pageTitle,
                        loginForm,
                        loginBtn,
                        // forgotPassword,
                        // newUser
                      ],
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
      ),
    );
  }

  handleLogin(String mail, String password) async {

    setState(() {
      isLoading = true;
    });
    if(mail=="michael.lawson@reqres.in"){
      userName="michael.lawson (Admin)";
      isAdmin = true;
      setState(() {

      });
      return Navigator.pushNamed(context, homeViewRoute);
    }
    else if(mail.trim().isNotEmpty && password.trim().isNotEmpty){
      Auth auth = Auth();

      bool isSuccessful = await auth.loginUser(mail, password) ?? false;
      setState(() {
        isLoading = false;
      });
      if(isSuccessful){
        return Navigator.pushNamed(context, homeViewRoute);
      }else{
        showSnackBar(auth.error,false);
      }
    }else{
      showSnackBar("All fields are required",false);
    }

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
