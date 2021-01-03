import 'package:data_demo2/models/user_model.dart';
import 'package:data_demo2/pages/home_page.dart';
import 'package:data_demo2/pages/sign_up_page.dart';
import 'package:data_demo2/services/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SignInPage extends StatefulWidget {

  static final String id = 'sign_in_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _doSignIn() async{
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    var account = HiveDB().loadAccount();

    if(email == account.email){
      HiveDB().storeUser(User(email: email, password: password));

      User user = HiveDB().loadUser();

      print(user.email);
      print(user.password);
      Navigator.pushNamed(context, HomePage.id);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning!'),
              content: Text('Email entered incorrectly'),
              actions: [
                FlatButton(onPressed: () {
                  emailController.clear();
                  passwordController.clear();
                  Navigator.pop(context);
                }, child: Text('Again'))
              ],
            );
          }
      );
    }
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
            padding: EdgeInsets.only(left: 40, right: 40, top: 45, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                  radius: 22.5,
                ),
                SizedBox(height: 25,),
                Text('Welcome', style: TextStyle(color: Colors.cyan.shade300, fontSize: 15),),
                SizedBox(height: 5,),
                Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
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

                    //#password
                    Text('Password',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300], width: 1.0)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // #forget
                    Center(child: Text('Forget Password?', style: TextStyle(color: Colors.grey[400], fontSize: 16),),),
                    SizedBox(height: 30,),

                    //#sign in button
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        child: Text('Sign In', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),
                        onPressed: _doSignIn,
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
                            child: Text('Sign Up', style: TextStyle(color: Color(0xff077f7b), fontWeight: FontWeight.w500, fontSize: 15),),
                          onTap: () {
                              Navigator.pushReplacementNamed(context, SignUpPage.id);
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
