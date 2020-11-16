import 'package:flutter/material.dart';
import 'package:personal_expense/Widget/transactionList.dart';
import './Widget/createTransaction.dart';
import './Model/transaction.dart';
import './Widget/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _startTransactionCreationProcess(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return CreateTransaction(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final tx = Transaction(
      amount: txAmount,
      date: dateTime,
      title: txTitle,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  void deleteTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == transactionId;
      });
    });
  }

  bool _showChart = false;
  
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startTransactionCreationProcess(context);
          },
        ),
      ],
    );

    final bodyHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final transactionSection = Container(
      height: bodyHeight * 0.55,
      child: Card(
        child: TransactionList(
          _transactions,
          deleteTransaction,
        ),
      ),
    );

    final isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startTransactionCreationProcess(context);
        },
      ),
      body: ListView(
        children: <Widget>[
          !isLandscape
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: bodyHeight * 0.3,
                      child: Chart(_recentTransactions),
                    ),
                    transactionSection,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('Show chart'),
                        Switch(
                          value: _showChart,
                          onChanged: (isOn) {
                            setState(() {
                              _showChart = isOn;
                            });
                          },
                        ),
                      ],
                    ),
                    _showChart
                        ? Container(
                            height: bodyHeight * 0.7,
                            child: Chart(_recentTransactions),
                          )
                        : transactionSection,
                  ],
                ),
        ],
      ),
    );
  }
}
