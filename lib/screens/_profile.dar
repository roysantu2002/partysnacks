import 'package:haanzi_main/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();

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
