/*
import 'package:flutter/material.dart';
import 'package:haanzi_main/services/auth.dart';
import 'package:haanzi_main/models/user.dart';
import 'package:provider/provider.dart';
import 'package:haanzi_main/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
// import 'package:partysnacks/screens/initial.dart';
import 'package:partysnacks/screens/splashScreen.dart';

/*void main() => runApp(MaterialApp(
        */ /* title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.purple[800],
            accentColor: Colors.amber,
            accentColorBrightness: Brightness.dark),*/ /*
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => MyApp(),
        }));*/

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.purple[800],
            accentColor: Colors.amber,
            accentColorBrightness: Brightness.dark),
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => MyApp(),
        });
  }
}*/

/*var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Initial(),
};

void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));*/

//---------------

void main() => runApp(MyApp());

/*
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Wrapper(),
};
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //initialRoute: '/', // default is '/'
      routes: {
        // '/': (ctx) => SplashScreen(),
        // "/home": (ctx) => Initial(),
      },
    );
  }
}
