import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  ProviderFilse extends ChangeNotifier{

  bool isSelectedThems = false;

   lightThem()=> isSelectedThems;

   darkThems(bool value)async{
     var prefs = await SharedPreferences.getInstance();
        prefs.setBool('Thems', value);
       isSelectedThems =value;
     notifyListeners();
   }
}