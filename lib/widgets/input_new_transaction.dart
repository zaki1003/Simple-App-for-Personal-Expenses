import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTs;

  NewTransaction(this.addTs);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enterdAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enterdAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTs(enteredTitle, enterdAmount, _selectedDate);

    Navigator.of(context).pop(); //close bottom sheet after submiting
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5, //shadow
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'), //Like Hint
                controller: _titleController,
                //  onChanged: (val){ titleInput = val},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'), //Like Hint
                controller: _amountController,
                //   onChanged: (val) => amountInput= val,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _presentDatePicker(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date:  ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          )
                        : FlatButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                  ],
                ),
              ),
              RaisedButton(
                  elevation: 5,
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData),
            ],
          ),
        ),
      ),
    );
  }
}
