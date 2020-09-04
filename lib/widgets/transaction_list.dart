import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTs;
  TransactionList(this.transactions, this.deleteTs);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet !',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  // we use it to separate widgts and make some espace
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit
                        .cover, //we add fit for this image take height of container
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: widget.transactions.length,
            itemBuilder: (ctx, index) {
              return Dismissible(
                key: Key(widget.transactions[index].id),
                onDismissed: (direction) {
                  setState(() {
                    widget.transactions.removeAt(index);
                  });
                },
                child: TransactionItem(
                    transaction: widget.transactions[index],
                    deleteTs: widget.deleteTs),
              );
            },
          );
  }
}
