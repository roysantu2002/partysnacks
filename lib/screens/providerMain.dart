import 'package:flutter/material.dart';

class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DeliMeal'),
        ),
        body: Text('Provider'),
      ),
    );
  }
}
