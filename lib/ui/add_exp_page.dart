import 'package:exoenseapp/data/local/dbHelper.dart';
import 'package:exoenseapp/data/local/model/catModel.dart';
import 'package:exoenseapp/data/local/model/expenssmodel.dart';
import 'package:exoenseapp/domain/appConstant.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/bloc/expens_event.dart';
import 'package:exoenseapp/ui/dashboard_page.dart';
import 'package:exoenseapp/ui/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Secondpage extends StatefulWidget {
  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  TextEditingController amtController = TextEditingController();

  /// ShoweButtom:
  int selectedCatIndex = -1;

  /// Debit And credit:
  String expensType = 'Debit';
  List<String> expensTypeList = ['Debit', 'Credit', 'Loan', 'Brows', 'Lend'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: getTextField(
                      mHintU: 'Enter Your title', mLabelU: 'title'),
                ),
                mSpacing(),
                TextField(
                  controller: descController,
                  decoration:
                      getTextField(mHintU: 'Enter Your desc', mLabelU: 'desc'),
                ),
                mSpacing(),
                TextField(
                  controller: amtController,
                  decoration:
                      getTextField(mHintU: 'Enter Your amount', mLabelU: 'amount')
                          .copyWith(prefixText: '\$ '),
                ),
                mSpacing(),
                DropdownMenu(
                    width: double.infinity,
                    inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    initialSelection: expensType,
                    onSelected: (value) {
                      expensType = value ?? 'Debit';
                      setState(() {});
                    },
                    dropdownMenuEntries: expensTypeList.map((expensType) {
                      return DropdownMenuEntry(
                          value: expensType, label: expensType);
                    }).toList()),
                mSpacing(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 11.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, childAspectRatio: 2 / 2),
                            itemCount: AppConstant.mCat.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                selectedCatIndex = index;
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppConstant.mCat[index].imagePath,
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    AppConstant.mCat[index].title,
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: selectedCatIndex >= 0 ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppConstant.mCat[selectedCatIndex].imagePath,
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                ' - ${AppConstant.mCat[selectedCatIndex].title}',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          )
                        : Center(child: Text('Choosee')),
                  ),
                ),
                mSpacing(),
                ElevatedButton(
                    onPressed: () async {

                      if(titleController.text.isNotEmpty &&
                           descController.text.isNotEmpty &&
                           amtController.text.isNotEmpty &&
                           selectedCatIndex >-1) {

                      //  DbHelper dbHelper = DbHelper.getInstance();

                        var prefs = await SharedPreferences.getInstance();
                        String uid = prefs.getString('userId') ?? '';

                        context.read<ExpensBloc>().add(AddExpens(mdataE: ExpenssModels(

                            userIdE: int.parse(uid),
                            titleE: titleController.text,
                            descE: descController.text,
                            amtE: double.parse(amtController.text),
                            expensTypeE: expensType,
                            category_id:AppConstant.mCat[selectedCatIndex].idCat,
                            balance: 0,
                            created_at: DateTime.now().millisecondsSinceEpoch.toString())));

                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Homepage(),));

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Add!!')));
                        /*context.read<ProviderFilse>().getAddExpens(ExpenssModels(
                                userIdE: int.parse(uid),
                                titleE: titleController.text,
                                descE: descController.text,
                                amtE: double.parse(amtController.text),
                                expensTypeE: expensType,
                                category_id: AppConstant.mCat[selectedCatIndex].idCat,
                                balance: 0,
                                created_at: DateTime.now().millisecondsSinceEpoch.toString()),);
                        */

                      }

                      /// Aibur select kurile he tolt kamtu kora hobo :
                      /// selcetde idenx tu diba lagibo a  aru  expens type  tu bydefault choose nukurilo debit hoi thakibo khai korne iate select kuribo lage,
                      /// index nuhuli by default iku show nukuribo
                      // if (titleController.text.isNotEmpty &&
                      //     descController.text.isNotEmpty &&
                      //     amtController.text.isNotEmpty &&
                      //
                      //     /// -1 mane bydauflt iku show nokore but 0 hole show kuribo mane select kora buli
                      //     /// gome pua jabo  -1 t koi judi gater hoi mane 0 ,1 ,2, tatia select hoise
                      //     selectedCatIndex > -1) {
                      //
                      //   DbHelper dbHelper = DbHelper.getInstance();
                      //
                      //   var prefs = await SharedPreferences.getInstance();
                      //   String  uid = prefs.getString('userId') ?? '';
                      //
                      //
                      //
                      //   bool check = await dbHelper.addExpenss(ExpenssModels(
                      //
                      //     /// SharePrefrenc id match :
                      //       userIdE: int.parse(uid),
                      //       titleE: titleController.text,
                      //       descE: descController.text,
                      //       amtE: double.parse(amtController.text),
                      //       expensTypeE: expensType,
                      //       category_id: AppConstant.mCat[selectedCatIndex].idCat,
                      //       balance: 0 ,
                      //
                      //       /// 1960 start milisecond:
                      //       created_at:DateTime.now().millisecondsSinceEpoch.toString() ));
                      //   if(check){
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //         backgroundColor: Colors.green,
                      //         content: Text('Expens Add!!')));
                      //     Navigator.pop(context);
                      //   }else{
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //         backgroundColor:  Colors.red,
                      //         content: Text('Errro adding expens')));
                      //   }
                      //
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    child: Text('Add Expens'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
