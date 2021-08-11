import 'package:flutter/material.dart';
import 'package:kcash/utils/colors.dart';
class ServiceForm extends StatelessWidget {
  final int index;


  ServiceForm(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Transaction details"),
      ),
      body: Center(
        child: Text('detals page #$index'),
      ),
    );
  }
}
