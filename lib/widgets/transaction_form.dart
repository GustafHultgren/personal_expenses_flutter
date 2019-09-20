import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function addTransaction;
  TransactionForm({this.addTransaction});

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submit() {
    final title = titleController.text;
    final amount = amountController.text;
    if (title.isEmpty || amount.isEmpty) {
      return;
    } else {
      addTransaction(title, double.parse(amount));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => submit(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submit,
            )
          ],
        ),
      ),
    );
  }
}
