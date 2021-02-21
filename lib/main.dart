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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partysnacks/screens/start.dart';
import 'package:partysnacks/screens/authScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:partysnacks/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:partysnacks/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:partysnacks/screens/home/home_page.dart';
import 'package:partysnacks/screens/initial/initial_page.dart';
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

// void main() => runApp(MyApp());

/*
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Wrapper(),
};
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.red, accentColor: Colors.yellowAccent),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        //initialRoute: '/', // default is '/'
        routes: {
          // '/': (ctx) => SplashScreen(),
          // "/home": (ctx) => Start(),
          "/home": (ctx) => AuthenticationWrapper(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if (firebaseuser != null) {
      print(firebaseuser.uid);
      return HomePage();
    }
    return InitialPage();
  }
}
