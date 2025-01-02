import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/data/local/model/user_model.dart';
import 'package:exoenseapp/ui/on_boarding/sing_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  DbHelper._();

  static DbHelper getInstance()=> DbHelper._();

  Database? mDataD;


  /// Creat new Account = User
  static const USER_TABLE = 'u_table';
  static const USER_COLUMN_ID = 'u_id';
  static const USER_COLUMN_NAME = 'u_name';
  static const USER_COLUMN_EMAIL = 'u_email';
  static const USER_COLUMN_MOBL = 'u_moNo';
  static const USER_COLUMN_PASS = 'u_pass';
  static const USER_COLUMN_CREATED_AT = 'u_created_at';

  /// Expens App:

  static const EXP_TABLE = 'e_table';
  static const EXP_COLUMN_ID = 'e_id';
  static const EXP_USER_COLUMN_ID = 'e_u_id';
  static const EXP_COLUMN_TITLE = 'e_title';
  static const EXP_COLUMN_DESC = 'e_desc';
  static const EXP_COLUMN_AMT = 'e_amount';
  static const EXP_COLUMN_BALANCE = 'e_balance';
  static const EXP_COLUMN_TYPE = 'e_type';
  static const EXP_COLUMN_CATEGORY_Id = 'e_cat_Id';
  static const EXP_COLUMN_CREATED_AT = 'u_created_at';

  Future<Database>initDB()async{
    mDataD = mDataD ?? await openDB();
    return mDataD!;
  }

  Future<Database>openDB()async{

    var appDir = await getApplicationDocumentsDirectory();
    var dbpath = join(appDir.path, 'expensDB.db');

    return openDatabase(dbpath,version: 1,onCreate: (db, version) {
      print('create DB');
      
      /// User:
      db.execute('create table $USER_TABLE ( $USER_COLUMN_ID integer primary key autoIncrement, $USER_COLUMN_NAME text, $USER_COLUMN_EMAIL text, $USER_COLUMN_PASS text, $USER_COLUMN_MOBL text, $USER_COLUMN_CREATED_AT text)');
    
      /// Exp:
      db.execute('create table $EXP_TABLE ( $EXP_COLUMN_ID integer primary key autoIncrement, $EXP_USER_COLUMN_ID integer, $EXP_COLUMN_TITLE text, $EXP_COLUMN_DESC text, $EXP_COLUMN_AMT real, $EXP_COLUMN_TYPE text, $EXP_COLUMN_CATEGORY_Id integer, $EXP_COLUMN_CREATED_AT text, $EXP_COLUMN_BALANCE real)');
      },);


  }

  Future<bool> ifCheckAlredyExits({required nameDC,required emailDC, required mobileNo})async{
    var db = await initDB();
    List<Map<String,dynamic>> dataC = await db.query(USER_TABLE,
    where: '$USER_COLUMN_NAME = ? AND $USER_COLUMN_EMAIL = ? AND $USER_COLUMN_MOBL = ?', whereArgs:[nameDC,emailDC,mobileNo]);
    return dataC.isNotEmpty;
  }

  Future<bool>registerUser(UserModel newUserD)async{

    var db = await initDB();

     // if(!await ifCheckAlredyExits(match:newUserD)){
     //   int rowsEffected = await db.insert(USER_TABLE, newUserD.toMapU());
     //   return rowsEffected >0;
     //
     // } else{
     //    return false;
     // }

    int rowsEffected = await db.insert(USER_TABLE, newUserD.toMapU());
    return rowsEffected >0;
}

    Future<bool>authenticationUser({required emailDA,required passwordDA})async{

    var db = await initDB();
    List<Map<String,dynamic>>dataA = await db.query(USER_TABLE,
        where:'$USER_COLUMN_EMAIL =? AND $USER_COLUMN_PASS = ?',whereArgs: [emailDA,passwordDA] );

  if(dataA.isNotEmpty){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', dataA[0][USER_COLUMN_ID].toString());
  }
    return dataA.isNotEmpty;
  }


  /// Expenss App:
    Future<bool> addExpenss(ExpenssModels newExpens)async{
    var db = await initDB();


    ///  Logic: User id use kuribo lagibo karon
    ///  ExpensModelt thoka bur  insert pai goise but
    ///  user id pai jua nai khai karone olabo lagibo shareprehern pora:
    /// User id nidile  kutu kar id hoi gom pua najabo .
    /// aru iar pora o olabo pare aru dirct buttonr pora o olabo pare:
    /// mane ate lkhile aitu code tu tate likhibo nlage aru ,
    // var prefs= await SharedPreferences.getInstance();
    // String uid = prefs.getString('userId') ?? '';
    //
    // newExpens.userIdE = uid;

    int rowsEffected = await db.insert(EXP_TABLE,newExpens.toMapE() );
    return rowsEffected >0;
    }


    Future<List<ExpenssModels>> fectsExpens()async{
    var db = await initDB();

    List<Map<String,dynamic>> allExpens = await db.query(EXP_TABLE);

    List<ExpenssModels> newData =[];
    for(Map<String ,dynamic> dataEcah in allExpens){
      ExpenssModels ecahData = ExpenssModels.fromMapE(dataEcah);
      newData.add(ecahData);
    }
    return newData;
    }


    Future<bool>deletExp({required deletIdD})async{

    var db = await initDB();

    int rowsEffected = await db.delete(EXP_TABLE,
    where:'$EXP_USER_COLUMN_ID = ?',whereArgs:[deletIdD] );
    return rowsEffected >0;

    }

  //   Future<List<Map<String,dynamic>> fectsNote()async{
  //
  //   var db = await initDB();
  //   List<Map<String,dynamic>> allnotes = await db.query(USER_TABLE);
  //   return allnotes;
  // }
  //


  //
  // Future<bool>updateNotes({ required UserModel newUpdate,required upadteIdD})async{
  //
  //   var db = await initDB();
  //   int rowsEffected = await db.update(USER_TABLE,newUpdate.toMapU(),
  //   where:'$USER_COLUMN_ID = ?',whereArgs:  [upadteIdD] );
  //   return rowsEffected >0;
  // }
  //
  // Future<bool>deletNotes({required deletId})async{
  //   var db  = await initDB();
  //
  //   int rowsEffected = await db.delete(USER_TABLE,where:'$USER_COLUMN_ID =?',whereArgs: [deletId]);
  //   return rowsEffected >0;
  // }
}