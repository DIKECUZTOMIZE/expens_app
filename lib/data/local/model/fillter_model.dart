import 'package:exoenseapp/data/local/model/expenssmodel.dart';

class FillterModels {

  String typenameFI;

  num totalamountFI;

  List<ExpenssModels> allExpenssFI ;

  FillterModels(
      {required this.typenameFI,
      required this.totalamountFI,
      required this.allExpenssFI});
}
