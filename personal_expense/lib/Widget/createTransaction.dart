
import 'package:flutter/material.dart';

class CreateTransaction extends StatefulWidget {
  final Function add;

  CreateTransaction(this.add);

  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);
    if (enteredTitle.isNotEmpty && enteredAmount != null && enteredAmount > 0) {
      widget.add(enteredTitle, enteredAmount);
    }
    print(enteredAmount);
    print(enteredTitle);
    Navigator.of(context).pop();
    // turn off the modal sheet on finishing
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Card(
              elevation: 7,
              child: Container(
                child: TextField(
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    focusColor: Colors.blue,
                  ),
                  controller: titleController,
                  onSubmitted: (_) => submitData,
                ),
              ),
            ),
            Card(
              elevation: 7,
              child: Container(
                child: TextField(
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    focusColor: Colors.blue,
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                submitData();
              },
              child: Text(
                'Add a new transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
