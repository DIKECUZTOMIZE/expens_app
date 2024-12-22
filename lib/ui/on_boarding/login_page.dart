import 'package:exoenseapp/data/local/dbHelper.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/homePage.dart';
import 'package:exoenseapp/ui/on_boarding/sing_up_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
 
 DbHelper dbHelper = DbHelper.getInstance();
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Icons:
            Center(
                child: Image(
              image: AssetImage('assets/icons/wine-bottle.png'),
              width: 100,
              height: 100,
            )),

            SizedBox(
              height: 11,
            ),

            /// Email:
            TextField(
              controller: emailController,
              decoration: getTextField(
                  mHintU:'Enter Your Email',
                  mLabelU: 'email'),
            ),

            SizedBox(
              height: 11,
            ),

            /// Password:
            TextField(
              controller: passController,
              obscureText: !isVisible,
              obscuringCharacter: '*',
              decoration: getTextField(
              mHintU:'Enter Your Password',
              mLabelU: 'password',
                mSuffixIcon: InkWell(

                    onTap: (){
                      isVisible = !isVisible;
                      setState(() {});
                    },
                  child:isVisible ? Icon(Icons.visibility): Icon(Icons.visibility_off) ,
                )

              ),
            ),

            SizedBox(height: 11,),

            /// Button:
            ElevatedButton(onPressed: ()async{

             if(emailController.text.isNotEmpty && passController.text.isNotEmpty){

              bool check= await dbHelper.authenticationUser(
                   emailDA: emailController.text,
                   passwordDA: passController.text);
              
              if(check){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content:Text('Password vul hoise tumar so try agin!!')));
              }
             }else{
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   backgroundColor: Colors.blue,
                   content: Text('fill hua nai pura koi so pleas try again')));
             }

            },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(100, 40),
                  maximumSize: Size(120, 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('login'),

                    SizedBox(width: 11,),
                    Icon(Icons.arrow_forward)
                  ],
                )),

            SizedBox(height: 11,),

            /// Forgrt:
            InkWell(onTap: (){},child: Text('forget password'),),

            SizedBox(height: 11,),

            /// Or:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               
                Expanded(
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
                Container(

                  width:20 ,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(5)
                  ),
                child: Text('OR'),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            SizedBox(height: 11,),

            /// Creat Account
            InkWell(onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SingUpPage(),));
            },child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tumar judi Acouunt nai? ',style: TextStyle(fontSize: 15),),
                SizedBox(width: 11),
                Text('Create Kuri lua',style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue),)
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
