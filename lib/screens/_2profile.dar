import 'package:haanzi_main/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  @override
  //MapScreenState createState() => MapScreenState();

  final AuthService _auth = AuthService();

  _ProfileScreenState createState() => _ProfileScreenState();
}
/*

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.save),
              label: Text('save'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/

class _ProfileScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  File _image;

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Profile'),
      ),

      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              //margin: EdgeInsets.fromLTRB(0.00, 20.00, 0.00, 0.00),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  new Container(
                    //height: 200.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 20.0),
                            child: new Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  child: ClipOval(
                                    child: new SizedBox(
                                      width: 130.0,
                                      height: 130.0,
                                      child: (_image != null)
                                          ? Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              'images/as.png',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      radius: 25.0,
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.camera_alt,
                                          size: 30.0,
                                        ),
                                        onPressed: () {
                                          getImage();
                                        },
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: ProfileCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    //FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    //FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Color(0xff00446F),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool val = false;
  String error = '';

  File _image;

  final GlobalKey<FormState> _formKey = GlobalKey();
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

    setState(() {
      _isLoading = false;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new Container(
                  //height: 200.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: new Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 130.0,
                                    height: 130.0,
                                    child: (_image != null)
                                        ? Image.file(
                                            _image,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'images/as.png',
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 25.0,
                                    child: IconButton(
                                      icon: new Icon(
                                        Icons.camera_alt,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        getImage();
                                      },
                                    ),
                                  )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'FULL NAME'),
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
                SizedBox(
                  height: 10,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
