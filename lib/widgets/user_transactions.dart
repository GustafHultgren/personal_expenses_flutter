import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';

import 'transaction_form.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TransactionForm(addTransaction: _addTransaction),
        // TransactionList(_transactions),
      ],
    );
  }
}
