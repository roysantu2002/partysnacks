import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:partysnacks/services/auth_service.dart';
import 'package:partysnacks/screens/nav/nav.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Tutorial',
      home: Nav(),
    );
  }
}
