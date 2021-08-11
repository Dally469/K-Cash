import 'package:flutter/material.dart';
import 'package:kcash/models/transaction_model.dart';
class TransactionDetails extends StatelessWidget {
  final TransactionModel transactionModel;


  TransactionDetails(this.transactionModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction details"),
      ),
      body: Center(
        child: Text('detals page #$transactionModel'),
      ),
    );
  }
}
