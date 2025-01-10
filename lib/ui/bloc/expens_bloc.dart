import 'package:exoenseapp/data/local/dbHelper.dart';
import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/bloc/expens_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensBloc extends Bloc<ExpensEvent,ExpensState>{

  DbHelper dbHelper;

  List<ExpenssModels> mdataB=[];
  ExpensBloc({required this.dbHelper }):super(ExpensInitialState()){

    on<AddExpens>((event, emit) async{

     emit(ExpensLoadingState());
      bool check = await dbHelper.addExpenss(event.mdataE);
          if(check){
            mdataB = await dbHelper.fectsExpens();
            emit( ExpensLoadedState(mDataS: mdataB));
          }else{
            emit(ExpensErorrState(errorMase: 'Expens cannot be added!!'));
          }
    },);

    on<FectsExpenss>((event, emit) async{

      emit(ExpensLoadingState());

      mdataB = await dbHelper.fectsExpens();

      emit(ExpensLoadedState(mDataS: mdataB));

    },);


  }








}