import 'package:flutter/material.dart';
import '../Model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions yet.'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                // return Card(
                //   child:
                // Row(
                //   children: <Widget>[
                //     Container(
                //       margin:
                //           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //       padding: EdgeInsets.all(5),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Theme.of(context).primaryColorLight,
                //           width: 3,
                //         ),
                //       ),
                //       child: Text(
                //         '\$${_transactions[index].amount.toString()}',
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           color: Theme.of(context).primaryColorDark,
                //         ),
                //       ),
                //     ),
                //     Column(
                //       children: <Widget>[
                //         Container(
                //           child: Text(
                //             _transactions[index].title,
                //             textAlign: TextAlign.left,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //         ),
                //         Container(
                //           child: Text(
                //             DateFormat('yMMMMd')
                //                 .format(_transactions[index].date),
                //             style: TextStyle(
                //               fontSize: 10,
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ),
                //       ],
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //     ),
                //   ],
                // ),

                // );

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${_transactions[index].amount.toString()}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              //color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('yMMMMd').format(_transactions[index].date),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
