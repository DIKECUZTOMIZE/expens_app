import 'dart:async';

import 'package:exoenseapp/ui/homePage.dart';
import 'package:exoenseapp/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String uid= '';
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),()async{

      var prefs =await SharedPreferences.getInstance();
      uid= prefs.getString('userId') ?? '';

      Widget navigatorT = LoginPage();

      if(uid != ''){
      navigatorT= Homepage();

      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navigatorT,));
         });
  }
  @override
  Widget build(BuildContext context) {

    // Timer(Duration(seconds: 3),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    // });
    return Scaffold(
      body: Center(child: Container(
        height: 100,
        width: 100,
        child: Image(image: AssetImage('assets/icons/wine-bottle.png'),),
      )),
    );
  }
}
