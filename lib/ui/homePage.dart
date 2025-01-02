import 'package:d_chart/d_chart.dart';
import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/data/local/model/fillter_model.dart';
import 'package:exoenseapp/domain/appConstant.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/bloc/expens_state.dart';
import 'package:exoenseapp/ui/add_exp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<ExpenssModels> mDataH = [];

  List<FillterModels> fillterData = [];

  List<String> mt = ['Debit', 'Credit'];

   List<DateFormat> mDatag= [

     DateFormat.y(),
     DateFormat.d(),
     DateFormat.m(),
   ];
  DateFormat selectedWise = DateFormat.m();
//  String selectedWise = 'This Wise';
  List<String> selectedTypeList = ['Month', 'Date', 'Year'];

  List<String> typeOfDateTime = [
    'Jan',
    'Frb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jyl',
    'Agst',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  DateFormat mFormet = DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();

    context.read<ExpensBloc>().add(FectsExpenss());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monety',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              size: 40,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Account:
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
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
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(.5)),
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
                Expanded(
                  flex: 1,
                  child: DropdownMenu(
                    width: 200,
                    initialSelection: selectedWise,
                    onSelected: (value) {

                      //  selectedWise =  selectedWise.isNotEmpty ? fillteNotesDataWise(allexp:,isupdate: true): 'This Wise';

                      selectedWise = value ??   DateFormat.y();

                      setState(() {});

                    },
                    textStyle: TextStyle(fontWeight: FontWeight.w500),
                    dropdownMenuEntries:mDatag.map((wise) {
                      return DropdownMenuEntry(value: wise, label: 'selected');
                    }).toList(),
                  ),
                ),
              ],
            ),

            mSpacing(),

            Container(
              padding: EdgeInsets.all(21),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff5F6DC9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expense total',
                    style: TextStyle(color: Colors.white),
                  ),
                  mSpacing(),
                  Text(
                    '\$ ${'3,734'}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
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
                        style: TextStyle(color: Colors.white24.withOpacity(.5)),
                      )
                    ],
                  )
                ],
              ),
            ),

            mSpacing(),

            Text(
              'Expense List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            mSpacing(),

            Expanded(child: BlocBuilder<ExpensBloc, ExpensState>(
              builder: (context, state) {

                if (state is ExpensLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                else if (state is ExpensErorrState) {
                  return Text(state.errorMase);
                }

                else if (state is ExpensLoadedState) {

                  fillteNotesDataWise(allexp: state.mDataS);

                  List<OrdinalData> mDataGraph = [];

                  num hiegestAmount = 0;
                  num highestAmountIndex = -1;

                  for (FillterModels echDatafillter in fillterData) {

                    if (hiegestAmount < echDatafillter.totalamountFI) {
                       hiegestAmount = echDatafillter.totalamountFI;
                    }

                      mDataGraph.add(OrdinalData(
                        domain: echDatafillter.typenameFI,
                        measure: echDatafillter.totalamountFI));
                  }
                  return state.mDataS.isNotEmpty ? Column(
                         // mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                           /* AspectRatio(
                              aspectRatio: 16/9,
                              child: DChartBarO(

                                allowSliding: true,
                                //  layoutMargin: LayoutMargin(left, top, right, bottom),
                                  groupList: [
                                    OrdinalGroup(id: '1', data: mDataGraph),

                                    //OrdinalGroup(id: '2', data: mDataGraph)

                                  ],
                                  

                                  fillColor: (group, Data, index) {
                                    return Data.measure == hiegestAmount
                                        ? Colors.blue
                                        : Colors.orange;
                                  },

                                  domainAxis: DomainAxis(
                                   

                                  //numericViewport: NumericViewport(9, 9),
                                   // ordinalViewport: OrdinalViewport( '2024 jan', 2),
                                    useGridLine: true,
                                    gapAxisToLabel: 1,
                                    //gapAxisToLabel: 10,
                                    


                                  ),

                                  measureAxis: MeasureAxis(
                                      // noRenderSpec: true
                                    //numericViewport: NumericViewport(0, 10)
                                    

                                      ),
                                  //  layoutMargin: LayoutMargin(1, 5, 10, 15),

                                  animate: true,

                                  
                                  configRenderBar: ConfigRenderBar(
                                    radius: 5,
                                  )),
                            ),*/

                        /*    AspectRatio(
                                aspectRatio: 16/9 ,
                            child:DChartPieO(

                              customLabel: (ordinalData, index) {

                                 return '${ordinalData.domain} \n  ${ordinalData.measure}';
                              },
                                animate: true,

                                configRenderPie: ConfigRenderPie(
                                  //arcRatio:1/2,
                                  //arcLength:20,

                                  arcLabelDecorator: ArcLabelDecorator(
                                    showLeaderLines: true,
                                    outsideLabelStyle: LabelStyle(fontSize: 20),
                                    leaderLineStyle: ArcLabelLeaderLineStyle(color: Colors.red, length: 3.3, thickness: 2.3),

                                    // insideLabelStyle: LabelStyle(
                                    //   color: Colors.black,
                                    //   fontSize: 20,
                                    // ),

                                  )
                                ),
                                data: mDataGraph))*/

                            Expanded(
                              child: ListView.builder(
                                itemCount: fillterData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(.2)),
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(fillterData[index]
                                                  .typenameFI),
                                              Text(
                                                '\$  ${fillterData[index].totalamountFI}',
                                                style: TextStyle(),
                                              )
                                            ],
                                          ),

                                          Divider(),

                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: fillterData[index]
                                                .allExpenssFI
                                                .length,
                                            itemBuilder: (context, childindex) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child: Row(
                                                      children: [
                                                        ///  image Cat
                                                        Container(
                                                            child: Image(
                                                          image: AssetImage(
                                                              AppConstant.mCat
                                                                  .where((exp) {
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
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        //  Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(fillterData[index].allExpenssFI[childindex].created_at)))),

                                                        Text(
                                                            '${fillterData[index].allExpenssFI[childindex].amtE}',),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      : Text('Notr Data');
                }

                else {
                  return Container();
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Secondpage(),
              ));
        },
        child: Text('Add'),
      ),
    );
  }

  void fillteNotesDataWise({required List<ExpenssModels> allexp}) {

    fillterData.clear();

    List<String> uniqueDate = [];

    for (ExpenssModels eachExp1 in allexp) {
      String eachDate1 =  mFormet.format(
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
        String ecahDate2 = mFormet.format(DateTime.fromMillisecondsSinceEpoch(
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
          typenameFI:  ecahUniqDate,
          totalamountFI: totalAmount,
          allExpenssFI: ecahDateExp));
      //fillterData.add(FillterModels(typenameFI:ecahUniqDate, totalamountFI:totalAmount,allExpenssFI :ecahDateExp));
    }
  }
}
