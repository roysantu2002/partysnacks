import 'package:haanzi_main/models/user.dart';
import 'package:haanzi_main/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:haanzi_main/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:haanzi_main/models/user.dart';
import 'package:haanzi_main/common/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  //MapScreenState createState() => MapScreenState();

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  File _image;

  final uid = AuthService().getCurrentUser();
  //print("AAAAAAAAAAA $uid");

  // print(currentUser.uid);

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Profile'),
        centerTitle: true,
      ),

      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
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
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  //final AuthService _auth = AuthService();
  bool loading = false;
  bool val = false;
  String error = '';
  File _image;

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "This is Long Toast",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  //static File _image;

  //static final uid = AuthService().userid();
  //static final String filepath = 'images/$uid' + '.png';

  /* Future<File> loadImage() async {
    print("Loading....");
    final _loader =
        FirebaseStorage.instance.ref().child(filepath).getDownloadURL();
    print(_loader);

    */ /*   if (_loader != "") {
      _image = _loader.toString();
    } else {
      _image = null;
    }*/ /*
  }*/

  Future<void> _signout() {
    AuthService().signOut();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'name': '',
    'mobile': '',
    'address': '',
    'pin': '',
  };
  var _isLoading = false;
  //final _passwordController = TextEditingController();

  Future<void> _submit() async {
    //var uid = AuthService().userid();
    //print("AAAAAAAAAAA $uid");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await _auth.currentUser();
    var uid = currentUser.uid;
    print("AAAAAAAAAAA $uid");

    //String fileName = basename(_image.path);

    //if (_image == null) {
    //showLongToast();
    //util.showMessage("Select Profile Image");
    //}

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

    if (_image == null) {
      util.showMessage("Set profile image");
    }

    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://haanzi-c7870.appspot.com');
    final String filepath = '/images/profileImages/$uid' + '.png';

    //print("TODO-01");
    print(filepath);
    /* print(_loader);*/
    //_storage = FirebaseStorage(storageBucket: 'gs://haanzi-c7870.appspot.com');

    StorageUploadTask _uploadTask;

    _uploadTask = _storage.ref().child(filepath).putFile(_image);

    var _imageURL = await _storage.ref().child(filepath).getDownloadURL();
    _authData['pic'] = _imageURL;

    await DatabaseService(uid: uid).updateUserProfile(
        uid,
        _authData['pic'],
        _authData['name'],
        _authData['mobile'],
        _authData['address'],
        _authData['pin']);
  }

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

/*  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://haanzi-c7870.appspot.com/images');

    StorageUploadTask _uploadTask;

    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);

    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    StorageUploadTask uploadTask =
        _storage.ref().child('images').putFile(_image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final uid = AuthService().getCurrentUser();
    print(uid);

    Future<void> _loadImage() async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser currentUser = await _auth.currentUser();
      var uid = currentUser.uid;
      print("AAAAAAAAAAA $uid");
    }

    //final uid = AuthService().userid();
    //print("AAAAAAAAAAA $uid");
    //print("first build");
    //final user = Provider.of<User>(context);
    final deviceSize = MediaQuery.of(context).size;

    //print("USER ID: $user");

    return Card(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(18.0),
        padding: EdgeInsets.all(18.0),
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
                                  IconButton(
                                    icon: new Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[300],
                                      size: 30.0,
                                    ),
                                    onPressed: () {
                                      getImage();
                                    },
                                  )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Invalid Name!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['name'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile'),
                  //controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length != 10) {
                      return 'Mobile Number!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['mobile'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  //controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 15) {
                      return 'Adress is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['address'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Pin Code'),
                    //controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Pin is too short Number!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['pin'] = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Container(
                                child: new RaisedButton(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Theme.of(context).backgroundColor),
                              ),

                              //color:  color: Theme.of(context).backgroundColor),
                              onPressed: () {
                                _submit();
                              },

                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              color: Theme.of(context).buttonColor,
                            )),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Container(
                                child: new RaisedButton(
                              child: new Text("CANCEL"),
                              textColor: Colors.white,
                              color: Color(0xff99463c),
                              onPressed: () {
                                _signout();
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                            )),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
