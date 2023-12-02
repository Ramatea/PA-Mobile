import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:managment/data/model/add_date.dart';
//import 'package:managment/home.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Add_data> transactions = []; // List to store transactions
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize or fetch transactions when the page is loaded
  //   //List<Add_data> transactions = [];
  // }

  @override
  Widget build(BuildContext context) {
    List<Add_data> transactions = box.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 248, 248),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Navigate to the AddTransactionPage when "See all" is clicked
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Home()),
                //     );
                //   },
                  
                // ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return getList(transactions[index]);
                },
              ),
            ),
            
          ],
        ),
        ),
      );
  }
   
  
  Widget getList(Add_data history) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${history.name}.png', height: 40),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
        ),
      ),
    );
  }

  Widget get(Add_data history, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        history.delete();
        setState(() {});
      },
      child: get(index as Add_data, history as int),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still running, show a loading indicator or a splash screen.
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If there was an error, handle it here
          return Scaffold(
            body: Center(
              child: Text("You Don't Have Any History"),
            ),
          );
        } else if (snapshot.data == true) {
          // If there are transactions, navigate to the HistoryPage
          return HistoryPage();
        } else {
          // If there are no transactions, show a different screen
          return NoTransactionsScreen();
        }
      },
    );
  }

  Future<bool> hasTransactions() async {
    final box = await Hive.openBox<Add_data>('');
    return box.isNotEmpty;
  }
}

class NoTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No transactions found.'),
      ),
    );
  }
}
