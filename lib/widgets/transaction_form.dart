import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;
  TransactionForm({this.addTransaction});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime _date;
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submit() {
    final title = _titleController.text;
    final amount = _amountController.text;
    if (title.isNotEmpty && amount.isNotEmpty && _date != null) {
      widget.addTransaction(title, double.parse(amount), _date);
      Navigator.of(context).pop();
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        _date = date;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => submit(),
            ),
            Row(
              children: <Widget>[
                Text(_date == null ? 'No Date Chosen!' : DateFormat.yMMMd().format(_date)),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _showDatePicker,
                )
              ],
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: submit,
            )
          ],
        ),
      ),
    );
  }
}
