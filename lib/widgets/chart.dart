import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final amount = recentTransactions.fold(0.0, (dayTotal, transaction) {
        final isSameDay = DateFormat.yMMMd().format(transaction.date) ==
            DateFormat.yMMMd().format(weekDay);
        return isSameDay ? transaction.amount : 0.0;
      });
      return {'day': DateFormat.E().format(weekDay), 'amount': amount};
    });
  }

  double get weeklySpending => groupedTransactionValues.fold(
      0.0, (total, data) => data['amount'] as double);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: groupedTransactionValues
              .map((data) => Flexible(
                    fit: FlexFit.tight,
                    child: _ChartBar(
                      label: data['day'],
                      spending: data['amount'],
                      weeklySpending: weeklySpending,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double weeklySpending;

  _ChartBar({this.label, this.spending, this.weeklySpending});

  get weeklyFraction =>
      0.5; //weeklySpending == 0.0 ? 0.0 : spending / weeklySpending;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: Text('\$${spending.toStringAsFixed(0)}')),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: weeklyFraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
