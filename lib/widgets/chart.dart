import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    })
        .reversed
        .toList(); //today will be the last day,that for we can look to thrs days of thr week. reversed retun Iterable so we add toList()
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      // fold helps us to calculationg sum and return double. /*0.0 is  first value of sum*/
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        //is  a simple container which can only be used to add padding
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit
                    .tight, // with tight,we force a child into its assigned width or into its assigned size and it can't grow
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
