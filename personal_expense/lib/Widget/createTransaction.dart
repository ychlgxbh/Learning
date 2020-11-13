import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTransaction extends StatefulWidget {
  final Function add;

  CreateTransaction(this.add);

  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);
    if (enteredTitle.isNotEmpty && enteredAmount != null && enteredAmount > 0 && _selectedDate != null) {
      widget.add(enteredTitle, enteredAmount, _selectedDate);
    }
    print(enteredAmount);
    print(enteredTitle);
    print(DateFormat('yMMMMd').format(_selectedDate));
    Navigator.of(context).pop();
    // turn off the modal sheet on finishing
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
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
                  onSubmitted: (_) => _submitData,
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
                  onSubmitted: (_) => _submitData,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date you picked:',
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate != null
                            ? DateFormat('yMMMMd').format(_selectedDate)
                            : 'Date not chosen'),
                      ),
                      FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text('Choose Date'),
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                _submitData();
              },
              child: Text(
                'Add a new transaction',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
