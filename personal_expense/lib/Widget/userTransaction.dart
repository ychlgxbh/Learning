import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../Widget/createTransaction.dart';
import '../Widget/transactionList.dart';
import '../Model/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      amount: 25.52,
      title: 'food',
      id: '1',
      date: DateTime.now(),
    ),
    Transaction(
      amount: 37.62,
      title: 'petrol',
      id: '2',
      date: DateTime.now(),
    ),
  ];
  void _addNewTransaction(String txTitle, double txAmount) {
    final tx = Transaction(
      amount: txAmount,
      date: DateTime.now(),
      title: txTitle,
      id: (_transactions.length + 1).toString(),
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CreateTransaction(_addNewTransaction),
      TransactionList(_transactions),
    ]);
  }
}
