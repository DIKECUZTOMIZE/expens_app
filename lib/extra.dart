//
//  import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void main(){
//   runApp(Apph());
//  }
//
//  class Apph extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//         home:HomePageA() ,
//     );
//   }
//  }
//
//  class HomePageA extends StatefulWidget{
//
//   @override
//   State<HomePageA> createState() => _HomePageAState();
// }
//
// class _HomePageAState extends State<HomePageA> {
//
//
//   String selectedWise = 'This Wise';
//   List<String> selectedTypeList = ['Month', 'Date', 'Year'];
//
//   String selectedWise1 = 'This Wise1';
//   List<String> selectedTypeList1 = ['This Wise1','Month1', 'Date1', 'Year1'];
//
//   String expensType = 'Debit';
//   List<String> expensTypeList = ['Debit', 'Credit', 'Loan', 'Brows', 'Lend'];
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center
//         ,
//         children: [
//           DropdownMenu(
//
//             width: double.infinity,
//
//             enabled: true,
//             initialSelection: selectedWise,
//
//             onSelected: (value) {
//               selectedWise = value ?? 'This Wise';
//
//               setState(() {});
//
//             },
//             textStyle: TextStyle(fontWeight: FontWeight.w500),
//             dropdownMenuEntries:selectedTypeList.map((exp) {
//               return DropdownMenuEntry(value: exp, label: exp);
//             }).toList(),
//           ),
//
//           SizedBox(
//             height: 19,
//           ),
//
//           DropdownMenu(
//             width: double.infinity,
//               inputDecorationTheme: InputDecorationTheme(
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//
//
//
//             initialSelection: selectedWise1,
//               onSelected: (value){
//               selectedWise1 = value ?? 'This Wise';
//               setState(() {});
//               },
//
//               dropdownMenuEntries: selectedTypeList1.map((exp1){
//                 return DropdownMenuEntry(value: exp1, label: exp1);
//               }).toList()),
//
//           SizedBox(
//             height: 11,
//           ),
//
//           DropdownMenu(
//               width: double.infinity,
//               inputDecorationTheme: InputDecorationTheme(
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//
//               initialSelection: expensType,
//
//               onSelected: (value) {
//                 expensType = value ?? 'Debit';
//                 setState(() {});
//               },
//               dropdownMenuEntries: expensTypeList.map((expensType) {
//                 return DropdownMenuEntry(
//                     value: expensType, label: expensType);
//               }).toList()),
//
//
//
//
//
//
//
//
//         ],
//       ),
//     );
//   }
// }