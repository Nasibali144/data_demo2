import 'package:data_demo2/models/account_model.dart';
import 'package:data_demo2/pages/sign_in_page.dart';
import 'package:data_demo2/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SignUpPage extends StatefulWidget {

  static final String id = 'sign_up_page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var emailController = TextEditingController();
  var numberController = TextEditingController();
  var addressController = TextEditingController();

  void _doRegistered() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('You have already registered.'),
            actions: [
              FlatButton(onPressed: () {Navigator.pushReplacementNamed(context, SignInPage.id);}, child: Text('Sign In'))
            ],
          );
        }
    );
  }

  void _doSignUp() async {
    String email = emailController.text.toString().trim();
    String number = numberController.text.toString().trim();
    String address = addressController.text.toString().trim();

    HiveDB().storeAccount(Account(email: email, number: number, address: address));
    var account = HiveDB().loadAccount();
    print(account.email);
    print(account.number);
    print(account.address);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfully'),
            content: Text('Go to SignIn Page'),
            actions: [
              FlatButton(onPressed: () {Navigator.pushReplacementNamed(context, SignInPage.id);}, child: Text('Sign In'))
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff077f7b),
      body: Column(
        children: [
          // #header
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 40, right: 40, top: 60, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome', style: TextStyle(color: Colors.cyan.shade300, fontSize: 15),),
                SizedBox(height: 5,),
                Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
              ],
            ),
          ),

          // #body
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 40, right: 40, top: 60),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // #email
                    Text('Email',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300], width: 1.0)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // #number
                    Text('Number',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                          hintText: 'Enter Number',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300], width: 1.0)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //#address
                    Text('Address',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                          hintText: 'Enter Address',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300], width: 1.0)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //#sign in button
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),
                        onPressed: () {
                          HiveDB().isEmpty() ? _doSignUp() : _doRegistered();
                        },
                        color: Color(0xff077f7b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),

                    // #or
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.grey[400],),
                        ),
                        Text('   OR   ', style: TextStyle(color: Colors.grey[400], fontSize: 16),),
                        Expanded(
                          child: Divider(color: Colors.grey[400],),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(MaterialCommunityIcons.facebook, color: Colors.blueAccent, size: 20,),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(AntDesign.twitter, color: Colors.lightBlueAccent, size: 20,),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(FlutterIcons.instagram_ant, size: 20,),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),

                    // #sign_up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(color: Colors.grey[400], fontSize: 15),),
                        GestureDetector(
                          child: Text('Sign In', style: TextStyle(color: Color(0xff077f7b), fontWeight: FontWeight.w500, fontSize: 15),),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, SignInPage.id);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
