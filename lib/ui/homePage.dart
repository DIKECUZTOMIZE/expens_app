import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/domain/appConstant.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/bloc/expens_state.dart';
import 'package:exoenseapp/ui/dashboard_page.dart';
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

  DateFormat mFormat = DateFormat.MMMEd() ;
List<ExpenssModels>mDataH=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ExpensBloc>().add(FectsExpenss());
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white70,
        title: Text('Deshboard'),),

    body:getShowUi() ,

    floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Secondpage(),));
    },child: Text('Add'),),
    );

  }

  Widget getShowUi(){
    return BlocBuilder<ExpensBloc,ExpensState>(builder: (context, state) {

      if (state is ExpensLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else if (state is ExpensErorrState) {
        return Text('${state.errorMase}');
      }
      else if (state is ExpensLoadedState) {

        mDataH = state.mDataS;
        return
          Center(
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: Container(
                height: 900,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10)

                ),
                child: mDataH.isNotEmpty ? ListView.builder(
                         // state.mDataS.isNotEmpty ? ListView.builder(

                itemCount: mDataH.length,
                        //  itemCount: state.mDataS.length,
                itemBuilder: (context, index){

                //  var mDataH = state.mDataS;

                  return Padding(
                    padding: const EdgeInsets.all(21),
                    child: Column(

                      children: [

                        Row(
                          children: [

                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle
                              ),


                              child: Image.asset(AppConstant.mCat.where((expHI){
                                return expHI.idCat == mDataH[index].category_id;
                              }).toList()[0].imagePath),

                              // child: Image.asset(AppConstant.mCat.where((exp){
                              //   return exp['idHI'] == mDataH[index].category_id
                              // }).toList()[0]['imagePath']
                              //
                              // ).
                            ),

                            SizedBox(width: 20,),

                            Expanded(
                              flex: 2,
                              child: Column(
                                                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(mDataH[index].titleE,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),),
                                  Text(mDataH[index].descE,style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),

                            SizedBox(width: 100,),

                            Expanded(
                            flex: 2,
                                child: Column(
                                  children: [
                                    Text('\$ ${mDataH[index].amtE}',style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                        fontSize: 20),),

                                    Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mDataH[index].created_at,),)),style:
                                      TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                )),

                          ],
                        ),

                        SizedBox(height: 11,),

                        Container(height: 1,
                        width: double.infinity,
                        color: Colors.purple,)
                      ],
                    ),
                  );
                }

                        ) : Center(child: Text('not add expens')),
              ),
            ),
          );
      }
          else{
          return  Container();
      }
    },
    );
  }
}
