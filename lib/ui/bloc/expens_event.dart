import 'package:exoenseapp/data/local/model/expenssmodel.dart';

abstract class ExpensEvent {}



class AddExpens extends ExpensEvent{

  ExpenssModels mdataE;
  AddExpens({required this.mdataE});

}

class  FectsExpenss extends ExpensEvent{

}

