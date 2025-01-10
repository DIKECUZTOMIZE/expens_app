

import 'package:flutter/material.dart';

InputDecoration getTextField({required String mHintU,required String mLabelU ,mSuffixIcon }){
  return InputDecoration(

    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

    hintText:mHintU ,
    labelText: mLabelU,
    suffixIcon: mSuffixIcon

  );
}

Widget mSpacing({double mheigt = 11,double mwidth = 11}){
  return SizedBox(
    height:mheigt ,
    width: mwidth ,
  );
}


TextStyle getTextStyle20({Color mfontColor = Colors.black})=>TextStyle(
  fontSize: 20,
  color: mfontColor
);
TextStyle getTextStyle25({Color mfontColor = Colors.black})=>TextStyle(
  fontSize: 25,
  color: mfontColor
);

TextStyle getTextStyle40({Color mfontColor = Colors.black})=>TextStyle(
  fontSize: 40,
  color: mfontColor
);

TextStyle getTextStyle15({Color mfontColor = Colors.black})=>TextStyle(
  fontSize: 15,
  color: mfontColor
);

ElevatedButton getButtom(mButtomName)=>ElevatedButton(
    onPressed: (){},
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue
    ) ,
  child:mButtomName ,

);

