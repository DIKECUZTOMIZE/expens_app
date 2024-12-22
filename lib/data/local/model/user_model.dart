import 'package:exoenseapp/data/local/dbHelper.dart';

class UserModel {
  int? idU;
  String nameU;
  String emailU;
  String moNoU;
  String passU;
  String created_atU;

  UserModel(
      {this.idU,
      required this.nameU,
      required this.emailU,
      required this.moNoU,
      required this.passU,
      required this.created_atU});

  factory UserModel.formMapU(Map<String,dynamic>map){
    return UserModel(
        idU: map[DbHelper.USER_COLUMN_ID],
        nameU: map[DbHelper.USER_COLUMN_NAME],
        emailU: map[DbHelper.USER_COLUMN_EMAIL],
        moNoU: map[DbHelper.USER_COLUMN_MOBL],
        passU: map[DbHelper.USER_COLUMN_PASS],
        created_atU: map[DbHelper.USER_COLUMN_CREATED_AT]);
  }

Map<String,dynamic>toMapU(){
  return{
    DbHelper.USER_COLUMN_NAME : nameU,
    DbHelper.USER_COLUMN_EMAIL : emailU,
    DbHelper.USER_COLUMN_MOBL : moNoU,
    DbHelper.USER_COLUMN_PASS : passU,
    DbHelper.USER_COLUMN_CREATED_AT : created_atU,
  };
}
}
