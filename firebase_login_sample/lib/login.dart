import 'package:firebase_login_sample/home_page.dart';
import 'package:firebase_login_sample/sign_in.dart';
import 'package:flutter/material.dart';
import 'auth.dart';


class LoginPage extends StatefulWidget {

  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override 
  State<StatefulWidget> createState() => new _LoginPageState();

}

enum FormType{ 
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  
  final formKey = new GlobalKey<FormState>();


  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()) {
   
      form.save();
      return true;
    } else {
      return false;
      
    }
  }



  void validateAndSubmit() async {
    if(validateAndSave()) {
      try {
        if (_formType == FormType.login){ 
      
      String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
  // AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
  // FirebaseUser user = result.user;
        print('Signed in ${userId}');

     
      } else { 
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: ${userId}');

      }
         widget.onSignedIn();
    }
      catch(e) {
             print('Error: $e');
      } 
      }
    }
  

void moveToRegister() { 
  formKey.currentState.reset();
  setState(() { 
  _formType = FormType.register; 
});
}

void moveToLogin() {
   setState(() { 
  _formType = FormType.login; 
});
}

  @override 

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter login'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButton() +
             signInButton()
          ),
          ),
      ),
    );
  }

  

              List<Widget> buildInputs() {
                return [ 
                new TextFormField(
                            decoration: new InputDecoration(labelText: 'Email'),
                            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                            onSaved: (value) => _email = value,
                          ),
                          new TextFormField(
                              decoration: new InputDecoration(
                                labelText: 'Password'),
                                obscureText:true,
                                validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                                onSaved: (value) => _password = value,
                              
                            ),
            ];
            }

              List<Widget> buildSubmitButton() {
                if(_formType == FormType.login){  
                return [
                            new RaisedButton(
                                child: new Text('Login', style: new TextStyle(fontSize: 20.0),),
                                onPressed: validateAndSubmit,
                              
                            ),
                            new FlatButton(
                              child: new Text("Create an account", style: new TextStyle(fontSize: 20.0)) ,
                              onPressed: moveToRegister,
                            ),
                ];
              } else { 
                return [
                new RaisedButton(
                                child: new Text('Create an account', style: new TextStyle(fontSize: 20.0),),
                                onPressed: validateAndSubmit,
                              
                            ),
                            new FlatButton(
                              child: new Text("Have an account? Login", style: new TextStyle(fontSize: 20.0)) ,
                              onPressed: moveToLogin,
                            ),
                ];

              }
              }
              
              List<Widget> signInButton() {
                  return [OutlineButton(
                    splashColor: Colors.grey,
                    onPressed: () {
                        signInWithGoogle().whenComplete(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        });
                      },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  ];
                }
}
