import 'package:firebase_login_sample/login.dart';
import 'package:firebase_login_sample/sign_in.dart';
import 'package:flutter/material.dart';
import 'auth.dart'
;

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
        await auth.signOut();
        onSignedOut();
    } catch(e) {
        print(e);
    }
  }

  @override
 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcomee'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize:17.0, color: Colors.white)),
             onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
          )
        ],
      ),

      body: new Container(
        child: new Center(
          child: new Text('Welcome Emelleme Team :) ', style:new TextStyle(fontSize:32.0)),
        ),
      ),
    );
  }
}