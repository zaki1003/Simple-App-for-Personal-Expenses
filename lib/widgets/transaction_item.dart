import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  //final TransactionList widget;
  final Transaction transaction;
  final Function deleteTs;

  const TransactionItem(
      {Key key,
      //     @required this.widget,
      @required this.transaction,
      @required this.deleteTs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  '\$${transaction.amount.toStringAsFixed(2) /*fraction Digit (tadwir ila 0.01) */}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTs(transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTs(transaction.id),
              ),
      ),
    );
  }
}
