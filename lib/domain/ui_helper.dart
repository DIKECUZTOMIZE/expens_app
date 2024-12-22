

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




