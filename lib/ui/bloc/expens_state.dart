import 'package:exoenseapp/data/local/model/expenssmodel.dart';

abstract class ExpensState {}


class ExpensInitialState extends ExpensState{}

class ExpensLoadingState extends ExpensState{}


class  ExpensLoadedState extends ExpensState{

  List<ExpenssModels>mDataS;
  ExpensLoadedState({required this.mDataS});
}

class ExpensErorrState extends ExpensState{
  String errorMase;
  ExpensErorrState({required this.errorMase});
}