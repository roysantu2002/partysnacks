import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupHaanzi() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {});
      //Navigator.pushReplacementNamed(context, '/wrapper', arguments: {});
    });
  }

  @override
  void initState() {
    super.initState();
    setupHaanzi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hannzi-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SpinKitDualRing(
            color: Colors.purpleAccent,
            size: 70.0,
          ),
        ),
      ),
    );
  }
}
