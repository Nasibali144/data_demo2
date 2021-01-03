import 'package:data_demo2/pages/sign_in_page.dart';
import 'package:data_demo2/pages/sign_up_page.dart';
import 'package:data_demo2/services/db_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  static final String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information about your account'),
          content: Text('Email: $email\nNumber: $number\nAddress: $address'),
          actions: [
            FlatButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
          ],
        );
      }
    );
  }

  String email = "";
  String number = "";
  String address = "";

  readData() async{
    var account = HiveDB().loadAccount();
    print(account.toJson());

    setState(() {
      email = account.email;
      address = account.address;
      number = account.number;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FlatButton(
              color: Colors.purple[800],
              textColor: Colors.white,
              child: Text('Get your account information'),
              onPressed: () {
                readData();
                _dialog();
              },
            ),
            FlatButton(
              color: Colors.grey[800],
              textColor: Colors.white,
              child: Text('Delete Account'),
              onPressed: () {
                HiveDB().removeAccount();
                Navigator.pushReplacementNamed(context, SignUpPage.id);
              },
            ),
            FlatButton(
              color: Colors.deepOrange[900],
              textColor: Colors.white,
              child: Text('Change your password or email'),
              onPressed: () {
                HiveDB().removeUser();
                Navigator.pushReplacementNamed(context, SignInPage.id);
              },
            ),
          ],
        ),
      )
    );
  }
}
