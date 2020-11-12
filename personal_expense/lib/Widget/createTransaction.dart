
import 'package:flutter/material.dart';

class CreateTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function add;

  CreateTransaction(this.add);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);
    if (enteredTitle.isNotEmpty && enteredAmount != null && enteredAmount > 0) {
      add(enteredTitle, enteredAmount);
    }
    print(enteredAmount);
    print(enteredTitle);
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
