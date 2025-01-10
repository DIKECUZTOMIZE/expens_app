import 'package:d_chart/d_chart.dart';
import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/data/local/model/fillter_model.dart';
import 'package:exoenseapp/domain/appConstant.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/bloc/expens_state.dart';
import 'package:exoenseapp/ui/add_exp_page.dart';
import 'package:exoenseapp/ui/bottome_naviget_page.dart';
import 'package:exoenseapp/ui/provider/provider_filse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  bool islight = false;

  List<ExpenssModels> mDataH = [];

  List<FillterModels> fillterData = [];

  List<BottomNavigationBarItem> mDataB = [
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'acount')
  ];

  DateFormat mFormet = DateFormat.yM();

  DateFormat datemFormet = DateFormat.yMMMd();

  /// DropDown:
  String selectedWise = 'This Wise';

  List<String> selectedTypeList = [
    'This Wise',
    'Month wise',
    'Year Wise',
  ];

  //  List<String> typeOfDateTime = [
  //   'Jan',
  //   'Frb',
  //   'Mar',
  //   'Apr',
  //   'May',
  //   'Jun',
  //   'Jyl',
  //   'Agst',
  //   'Sep',
  //   'Oct',
  //   'Nov',
  //   'Dec'
  // ];

  @override
  void initState() {
    super.initState();

    context.read<ExpensBloc>().add(FectsExpenss());
  }

  @override
  Widget build(BuildContext context) {

    islight = Theme.of(context).brightness == Brightness.light ;
    return Scaffold(

      body: MediaQuery.of(context).orientation == Orientation.landscape ? Row(
        children: [
          Expanded(child: oneNoUi()),

          SizedBox(width: 10),

          Expanded(
              child: SingleChildScrollView(child: SizedBox(

                  width: double.infinity,
                  height: 400,
                  child: towNoUi())))
        ],
      )
          : SingleChildScrollView(
        child: SizedBox(
          height: 900,
          width: double.infinity,
          child: Column(
            children: [

              oneNoUi(),

              towNoUi()
            ],
          ),
        ),
      ),
    );
  }

  void fillteNotesDataWise({required List<ExpenssModels> allexp}) {
    fillterData.clear();

    List<String> uniqueDate = [];

    for (ExpenssModels eachExp1 in allexp) {
      String eachDate1 = datemFormet.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp1.created_at)));
      print(eachDate1);
      if (!uniqueDate.contains(eachDate1)) {
        uniqueDate.add(eachDate1);
      }
    }

    for (String ecahUniqDate in uniqueDate) {
      num totalAmount = 0.0;

      List<ExpenssModels> ecahDateExp = [];

      for (ExpenssModels eachexp2 in allexp) {
        String ecahDate2 = datemFormet.format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(eachexp2.created_at)));

        if (ecahUniqDate == ecahDate2) {
          ecahDateExp.add(eachexp2);

          if (eachexp2.expensTypeE == 'Debit') {
            totalAmount += eachexp2.amtE;
          } else if (eachexp2.expensTypeE == 'Credit') {
            totalAmount -= eachexp2.amtE;
          }
        }
      }

      print(uniqueDate);

      fillterData.add(FillterModels(

        // typenameFI: '${typeOfDateTime[int.parse(ecahUniqDate.split('/')[0]) - 1]},  ${ecahUniqDate.split('/')[1]}',

        //  typenameFI: '${datemFormet.format(DateTime.fromMillisecondsSinceEpoch(int.parse(ecahUniqDate)))}',   //  typenameFI:   ecahUniqDate,

          typenameFI: ecahUniqDate,
          totalamountFI: totalAmount,
          allExpenssFI: ecahDateExp));
      //fillterData.add(FillterModels(typenameFI:ecahUniqDate, totalamountFI:totalAmount,allExpenssFI :ecahDateExp));
    }
  }

  Widget oneNoUi(){
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SwitchListTile(

            title: Text('mode'),
            value: context.watch<ProviderFilse>().lightThem() ,
            onChanged: (value) { context.read<ProviderFilse>().darkThems(value);
            setState(() {});
            },),

          ListTile(
            title: Text(
              'Monety',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            trailing: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.search,
                size: 35,
              ),
            ),

          ),

          /// Account:
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child:
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 17,
                        backgroundImage: AssetImage('assets/img/img.png'),
                      ),

                      SizedBox(
                        width: 11,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moring',
                            style: getTextStyle20(mfontColor:islight ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.5))
                          ),
                          Text(
                            'Blaszczykowski',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  )),

              /// DropDown
              Expanded(
                flex: 1,
                child: DropdownMenu(
                  width: double.infinity,

                  //enabled: true,
                  initialSelection: selectedWise,

                  onSelected: (value) {
                    selectedWise = value ?? 'This Wise';

                    if (value == 'Year Wise') {
                      datemFormet = DateFormat.y();
                    } else if (value == "Month wise") {
                      datemFormet = DateFormat.yM();
                    } else if (value == "This Wise") {
                      datemFormet = DateFormat.yMMMd();
                    }

                    setState(() {});
                  },
                  textStyle: TextStyle(fontWeight: FontWeight.w500),
                  dropdownMenuEntries: selectedTypeList.map((exp) {
                    return DropdownMenuEntry(value: exp, label: exp);
                  }).toList(),
                ),
              ),
            ],
          ),

          mSpacing(),

          Container(
            padding: EdgeInsets.all(10),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff5F6DC9)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [



                Text(
                  'Expense total',
                  style: TextStyle(color: Colors.white),
                ),

                mSpacing(),

                Text(
                  '\$ ${'3,734'}',
                  style: getTextStyle40(mfontColor: Colors.white),
                ),

                mSpacing(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 25,
                      width: 55,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        '+ \$240',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    mSpacing(),

                    Text(
                      'than last month',
                      style: getTextStyle15(mfontColor: Colors.white.withOpacity(.5))),
                    
                  ],
                ),
              ],
            ),


          ),

          mSpacing(),
          
          Text('Expens List',style: getTextStyle25(mfontColor: islight ? Colors.black : Colors.white ),)
        ],
      ),
    );
  }

  Widget towNoUi(){
    return Expanded(
      child: BlocBuilder<ExpensBloc, ExpensState>(builder: (context, state) {

        if (state is ExpensLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        else if (state is ExpensErorrState) {
          return Text(state.errorMase);
        }

        else if (state is ExpensLoadedState) {

          fillteNotesDataWise(allexp: state.mDataS.reversed.toList());

          List<OrdinalData> mDataGraph = [];

          num hiegestAmount = 0;

          for (FillterModels echDatafillter in fillterData) {

            if (hiegestAmount < echDatafillter.totalamountFI) {
              hiegestAmount = echDatafillter.totalamountFI;
            }

            mDataGraph.add(OrdinalData(
                domain: echDatafillter.typenameFI,
                measure: echDatafillter.totalamountFI));
          }



          return state.mDataS.isNotEmpty ? ListView.builder(
            itemCount: fillterData.length,
            itemBuilder: (context, index) {

              bool isCredit = false;

             // isCredit = fillterData[index].allExpenssFI[index].expensTypeE ? 'Debit' : 'Credit';

              return Container(
                padding: EdgeInsets.all(21),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                        Colors.black.withOpacity(.2))),
                child: Column(

                  children: [

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(fillterData[index].typenameFI),
                        Text(
                            '-\$  ${fillterData[index].totalamountFI.toString()}')
                      ],
                    ),

                    Divider(),

                    /// Expense Data
                    ListView.builder(
                      physics:
                      NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: fillterData[index]
                          .allExpenssFI
                          .length,
                      itemBuilder: (context, childindex) {
                        return Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 13,
                              child: Row(
                                children: [
                                  Container(
                                      child: Image(
                                        image:
                                        AssetImage(
                                            AppConstant.mCat
                                                .where(
                                                    (exp) {
                                                  return exp
                                                      .idCat ==
                                                      fillterData[index]
                                                          .allExpenssFI[childindex]
                                                          .category_id;
                                                })
                                                .toList()[0]
                                                .imagePath),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        fillterData[index]
                                            .allExpenssFI[
                                        childindex]
                                            .titleE,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      Text(fillterData[
                                      index]
                                          .allExpenssFI[
                                      childindex]
                                          .descE)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                    '-\$ ${fillterData[index].allExpenssFI[childindex].amtE}'
                                  //  ,style: TextStyle(color:  fillterData == 'Debit' ? Colors.green : Colors.red),

                               ,style: TextStyle(color: fillterData[index].allExpenssFI[childindex].expensTypeE == 'Debit' ? Colors.green : Colors.red), ))
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            },
          )
              : Text('Note Data');
        }
        ///
        else {
          return Container();
        }

        ///
      },
      ),
    );

  }



}
