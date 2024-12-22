// import 'package:exoenseapp/data/local/dbHelper.dart';
// import 'package:exoenseapp/data/local/model/expenssmodel.dart';
// import 'package:exoenseapp/domain/appConstant.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProviderFilse extends ChangeNotifier{
//
//
//   DbHelper dbHelper = DbHelper.getInstance();
//
//   /// Initial
//   List<ExpenssModels> mdataP = [];
//
//   void getAddExpens(ExpenssModels newExpens) async {
//     bool check = await dbHelper.addExpenss(newExpens);
//     if (check) {
//       mdataP = await dbHelper.fectsExpens();
//       notifyListeners();
//     }
//   }
//
//   List<ExpenssModels> fectsExpens()=> mdataP;
//
//
//   }
//
