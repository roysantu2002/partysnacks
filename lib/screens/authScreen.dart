import 'dart:math';
import 'package:flutter/material.dart';
import 'package:haanzi_main/services/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('images/home-auth.png'),
//                fit: BoxFit.cover,home-auth.png
//              ),
//            ),
//          ),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home-auth.png'),
                  fit: BoxFit.cover,
                ),
              ),
              //margin: EdgeInsets.fromLTRB(0.00, 20.00, 0.00, 0.00),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: deviceSize.height * 0.10,
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool val = false;
  String error = '';
  String providerReceiver = "Receiver";
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      dynamic result = await _auth.signInWithEmailAndPassword(
          _authData['email'], _authData['password']);
      if (result == null) {
        setState(() => error = 'Couldn\'t signin');
      }
    } else {
      dynamic result = await _auth.registerWithEmailAndPassword(
          _authData['email'], _authData['password'], providerReceiver);
      if (result == null) {
        setState(() => error = 'please supply a valid data');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onSwitchValueChanged(bool newVal) {
    setState(() {
      val = newVal;
      if (val) {
        providerReceiver = "Receiver";
      } else {
        providerReceiver = "Provider";
      }

      print(providerReceiver);
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        margin: EdgeInsets.all(12),
        height: _authMode == AuthMode.Signup ? 380 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 380 : 260),
        width: deviceSize.width * 0.80,
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                if (_authMode == AuthMode.Signup)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Provider'),
                      Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: val,
                          onChanged: (newVal) {
                            onSwitchValueChanged(newVal);
                          }),
                      Text('Receiver'),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    elevation: 2,
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Theme.of(context).backgroundColor),
                    ),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).buttonColor,
                    //color: Theme.of(context).primaryColor,
                    //textColor: Theme.of(context).textTheme.headline,
                  ),
                FlatButton(
                  child: Text(
                    'OR ${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Color(0xffF8D774),
                  //textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
