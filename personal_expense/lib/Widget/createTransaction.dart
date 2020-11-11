import 'package:flutter/material.dart';

class CreateTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function add;

  CreateTransaction(this.add);

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
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                add(titleController.text, double.parse(amountController.text),);
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
