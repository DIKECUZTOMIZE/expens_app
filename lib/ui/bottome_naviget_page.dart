import 'package:exoenseapp/ui/add_exp_page.dart';
import 'package:exoenseapp/ui/home_page.dart';
import 'package:exoenseapp/ui/static_page.dart';
import 'package:flutter/material.dart';

class BottomNaviget extends StatefulWidget {
  @override
  State<BottomNaviget> createState() => _BottomNavigetState();
}

class _BottomNavigetState extends State<BottomNaviget> {

  int isSelectedIndex =2;

  List<Widget> _page =[
    Center(child:  Homepage(),),
    Center(child:  AddExpPage(),),
    Center(child:  StaticPage(),),

  ];

 @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:_page[isSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap:(value){
            isSelectedIndex = value ;
            setState(() {});
          },
          currentIndex:isSelectedIndex ,
          items:[
            BottomNavigationBarItem(icon:Icon(Icons.home_outlined,),label: ''),
            BottomNavigationBarItem(icon:Icon(Icons.add,),label: ''),
            BottomNavigationBarItem(icon:Icon(Icons.graphic_eq,),label: ''),
          ] ),

    );
  }
}
