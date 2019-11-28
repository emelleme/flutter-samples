import 'package:firebase_login_sample/login.dart';
import 'package:firebase_login_sample/sign_in.dart';
import 'package:firebase_login_sample/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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

drawer: NavDrawer(),
   body: SlidingUpPanel(
      renderPanelSheet: false,
      panel: _floatingPanel(),
      collapsed: _floatingCollapsed(),
      body: Center(
        child: Text("Map will go here"),
      ),
    ),
    );
  }
}


Widget _floatingCollapsed(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    child: Center(
      child: Text(
        "Find a Doctor",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _floatingPanel(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ]
    ),
    margin: const EdgeInsets.all(24.0),
    child: Center(
      child: Text("This is the SlidingUpPanel when open"),
    ),
  );
}