import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Container(
            height: 400,
            child: Image(
              image: AssetImage("images/icon-logo.png"),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          RichText(
            text: TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'PartySnacks',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ]),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Unpack & Crack',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.only(left: 30, right: 30),
                onPressed: () {},
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.red,
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                padding: EdgeInsets.only(left: 30, right: 30),
                onPressed: () {},
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          // with custom text
          SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
