import 'package:d_chart/d_chart.dart';
import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/data/local/model/fillter_model.dart';
import 'package:exoenseapp/domain/appConstant.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/bloc/expens_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StaticPage extends StatefulWidget {
  @override
  State<StaticPage> createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {

  List<FillterModels> mFilterData=[];
  DateFormat mFormate = DateFormat.yMMMd();

  List<ExpenssModels> mDataStaic=[];



  @override
  void initState() {
    super.initState();

    context.read<ExpensBloc>().add(FectsExpenss());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sataic'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              oneUi(),

              mSpacing(),

              towUi()

            ],
          ),
        ),
      ),
    );


  }

  Widget oneUi(){
    return  Container(
      padding: EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff6574D3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Expense',style: TextStyle(
            color: Colors.white,fontSize: 20,),),

          Row(
            children: [
              Text('\$ 3,734',style: TextStyle(
                  fontSize: 30,fontWeight: FontWeight.w500,
                  color: Colors.white),),

              mSpacing(),

              Text('/ \$ 4000 per month ',style:  getTextStyle15(mfontColor: Colors.white.withOpacity(.5)))
            ],
          ),

          mSpacing(),
          Container(
            height: 4,
            width: double.infinity,
            color: Colors.yellow,
          )


        ],
      ),
    );
  }
  Widget towUi() {
    return BlocBuilder<ExpensBloc, ExpensState>(
      builder: (context, state) {
        if (state is ExpensLoadingState) {
          return Center(child: CircularProgressIndicator(),);
        }
        else if (state is ExpensErorrState) {
          return Text('${state.errorMase}');
        }
        else if (state is ExpensLoadedState) {

          mDataStaic = state.mDataS;

          getFillter(allExp: state.mDataS);

          List<OrdinalData> mDataGraph = [];

          num highestAmount = 0;

          for(FillterModels eachGraphData in mFilterData){

             if(highestAmount < eachGraphData.totalamountFI ){
               highestAmount = eachGraphData.totalamountFI;
             }

             mDataGraph.add(OrdinalData(domain: eachGraphData.typenameFI,
                 measure: eachGraphData.totalamountFI));
          }

          return state.mDataS.isNotEmpty
              ? Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16/9,
                      child: DChartBarO(

                          measureAxis: MeasureAxis(
                            showLine: true,

                          ),
                          animate: true,

                          fillColor: (group, ordinalData, index) {
                         return   ordinalData.measure ==  highestAmount ? Colors.blue :Colors.green;
                          },

                          groupList: [
                            OrdinalGroup(id:'1' , data: mDataGraph)
                          ]),
                    ),

                      mSpacing(),

                    GridView.builder(
                       shrinkWrap: true,
                     //physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 11,
                        childAspectRatio: 2/1
                           ),
                      itemCount:mDataStaic.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(

                            children: [
                              Image.asset('${AppConstant.mCat.where((expIcon){
                                return expIcon.idCat == mDataStaic[index].category_id ;
                              }).toList()[0].imagePath}',height: 40,width: 40,),

                              mSpacing(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text(mDataStaic[index].titleE),
                                Text('${mDataStaic[index].amtE.toString()}')
                              ],)
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )
              : Text('Note Add Data');
        } else {
          return Container();
        }
      },

    );
  }

  void getFillter({required List<ExpenssModels> allExp}){

    List<String> uniuqDate = [];

    for(ExpenssModels eachExp1 in allExp){
      String ecahDate1 = mFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp1.created_at)));

      if(!uniuqDate.contains(ecahDate1)){
        uniuqDate.add(ecahDate1);
      }
    }

    for(String ecahDateUnique in uniuqDate){

      List<ExpenssModels> dateAndExp =[];

      num totalAmount =0;

      for(ExpenssModels eachExp2 in allExp){
        String ecahDate2 = mFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp2.created_at)));

      if(ecahDateUnique == ecahDate2){
        dateAndExp.add(eachExp2);

        if(eachExp2.expensTypeE == 'Debit'){
          totalAmount += eachExp2.amtE;
      }
        else{
          totalAmount -= eachExp2.amtE;
        }

      }

     // mFilterData.add(FillterModels(typenameFI: ecahDateUnique, totalamountFI: totalAmount, allExpenssFI: dateAndExp));

    }
      mFilterData.add(FillterModels(typenameFI: ecahDateUnique, totalamountFI: totalAmount, allExpenssFI: dateAndExp));

    print(uniuqDate);
  }
}
}
