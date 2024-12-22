import 'package:exoenseapp/data/local/dbHelper.dart';
import 'package:exoenseapp/data/local/model/user_model.dart';
import 'package:exoenseapp/domain/ui_helper.dart';
import 'package:exoenseapp/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';

class SingUpPage extends StatefulWidget {
  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  DbHelper dbHelper = DbHelper.getInstance();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var mbNoController = TextEditingController();
  var passwordController = TextEditingController();
  var confrimPasswordController = TextEditingController();

  /// Password:
  bool isVisiblePass = false;

  bool isVisibleConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              children: [
                /// Icons
                Center(
                    child: Image(
                  image: AssetImage('assets/icons/wine-bottle.png'),
                  width: 100,
                  height: 100,
                )),

                mSpacing(),

                /// Name:
                TextField(
                  controller: userNameController,
                  decoration: getTextField(
                      mHintU: 'Enter Your name',
                      mLabelU: 'name',
                      mSuffixIcon: Icon(Icons.account_circle)),
                ),

                mSpacing(),

                /// Email:
                TextField(
                  controller: emailController,
                  decoration: getTextField(
                      mHintU: 'Enter Your Email',
                      mLabelU: 'Email',
                      mSuffixIcon: Icon(Icons.email)),
                ),

                mSpacing(),

                /// Mobile Number:
                TextField(
                  controller: mbNoController,
                  keyboardType: TextInputType.phone,
                  decoration: getTextField(
                      mHintU: 'Mobile Number',
                      mLabelU: 'Mobile Number',
                      mSuffixIcon: Icon(Icons.numbers)),
                ),

                mSpacing(),

                /// Password:
                TextField(
                  obscureText: !isVisiblePass,
                  obscuringCharacter: '*',
                  controller: passwordController,
                  decoration: getTextField(
                      mHintU: 'Password',
                      mLabelU: 'Password',
                      mSuffixIcon: InkWell(
                        onTap: () {
                          isVisiblePass = !isVisiblePass;
                          setState(() {});
                        },
                        child: isVisiblePass
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      )),
                ),

                mSpacing(),

                /// ConfirmPassword:
                TextField(
                    controller: confrimPasswordController,
                    obscureText: isVisibleConfirm,
                    obscuringCharacter: '*',
                    decoration: getTextField(
                      mHintU: 'Confirm Password',
                      mLabelU: 'Confirm Password',
                      mSuffixIcon: InkWell(
                        onTap: () {
                          isVisibleConfirm = !isVisibleConfirm;
                          setState(() {});
                        },
                        child: isVisibleConfirm
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    )),

                mSpacing(),

                ElevatedButton(
                    onPressed: () async {
                      if (userNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          mbNoController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confrimPasswordController.text.isNotEmpty) {

                        if (passwordController.text == confrimPasswordController.text) {
                          if (await dbHelper.ifCheckAlredyExits(
                              nameDC: userNameController.text,
                              emailDC: emailController.text,
                              mobileNo: mbNoController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.orange,
                                content:
                                    Text('name alredy ase so login kora')));
                          } else {
                            bool check = await dbHelper.registerUser(UserModel(
                                nameU: userNameController.text,
                                emailU: emailController.text,
                                moNoU: mbNoController.text,
                                passU: passwordController.text,
                                created_atU: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString()));
                            if (check) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('Successfuly resiter')));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('register hua nai try agin!!')));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'match hua nai password aru confrimpassword tu pleas try agin!!')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text(
                                'Kali thai pur kora hua nai pleas fill krok!!')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(150, 40)),
                    child: Text('Sing Up')),
                mSpacing(),

                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tumar account ase judi?',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        'login kora',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
