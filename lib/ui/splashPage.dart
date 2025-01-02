import 'dart:async';

import 'package:exoenseapp/domain/ui_helper.dart';
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

      Widget navigatorTo = LoginPage();

      if(uid != ''){
      navigatorTo= Homepage();

      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navigatorTo,));
         });
  }
  @override
  Widget build(BuildContext context) {

    // Timer(Duration(seconds: 3),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    // });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Stack(
          children: [
            Positioned(
                top: 40,
                left: 150,
                child: Text('Monety',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


              
                Image.asset('assets/img/bg-monety.png'),
                Text('Easy way to monitor',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                Text('your expense',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),),

               mSpacing(),
                Text('Safe yoyr future by managing your expense right now',textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 18,color: Colors.black.withOpacity(.5)
                ),)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
