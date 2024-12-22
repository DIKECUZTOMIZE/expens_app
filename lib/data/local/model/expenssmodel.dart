import 'package:exoenseapp/data/local/dbHelper.dart';

class ExpenssModels {
  int? idE;
  int userIdE;
  String titleE;
  String descE;
  double amtE;
  String expensTypeE;
  int category_id;
  double balance;
  String created_at;



  ExpenssModels(
      {this.idE,
      required this.userIdE,
      required this.titleE,
      required this.descE,
      required this.amtE,
      required this.expensTypeE,
      required this.category_id,
      required this.balance,
      required this. created_at

      });

  factory ExpenssModels.fromMapE(Map<String,dynamic>map){
    return ExpenssModels(
        idE: map[DbHelper.EXP_COLUMN_ID],
        userIdE:map[DbHelper.EXP_USER_COLUMN_ID],
        titleE: map[DbHelper.EXP_COLUMN_TITLE],
        descE: map[DbHelper.EXP_COLUMN_DESC],
        amtE: map[DbHelper.EXP_COLUMN_AMT],
        expensTypeE:map[DbHelper.EXP_COLUMN_TYPE],
        category_id:map[DbHelper.EXP_COLUMN_CATEGORY_Id],
        balance: map[DbHelper.EXP_COLUMN_BALANCE],
        created_at:map[DbHelper.EXP_COLUMN_CREATED_AT]);
  }


  Map<String,dynamic> toMapE(){
    return{
        DbHelper.EXP_USER_COLUMN_ID:userIdE,
        DbHelper.EXP_COLUMN_TITLE:titleE,
        DbHelper.EXP_COLUMN_DESC:descE,
        DbHelper.EXP_COLUMN_AMT:amtE,
        DbHelper.EXP_COLUMN_TYPE:expensTypeE,
        DbHelper.EXP_COLUMN_CATEGORY_Id:category_id,
        DbHelper.EXP_COLUMN_BALANCE:balance,
        DbHelper.EXP_COLUMN_CREATED_AT:created_at,
    };
  }
}
