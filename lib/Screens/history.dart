import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:managment/data/model/add_date.dart'; // Assuming the correct path to 'add_date.dart'
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivitas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid) // Access current user UID directly
            .collection('History')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> historyDocs = snapshot.data!.docs;

          return Expanded(
            child: ListView.builder(
              itemCount: historyDocs.length,
              itemBuilder: (context, index) {
                var orderItem = historyDocs[index];
                String orderId = orderItem.id;
                Timestamp date = orderItem['date'] as Timestamp;
                String amount = orderItem['amount'];
                String category = orderItem['category'];
                String explanation = orderItem['explanation'];
                String itemType = orderItem['itemType'];  

                return GestureDetector(
                  onTap: () {},
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
                        child: Image.asset('images/${orderItem['name']}.png', height: 40), // Access 'name' from orderItem
                      ),
                      title: Text(
                        orderItem['name'], // Access 'name' from orderItem
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${day[date.toDate().weekday - 1]}  ${date.toDate().year}-${date.toDate().day}-${date.toDate().month}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Text(
                        amount,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: orderItem['IN'] == 'Income' ? Colors.green : Colors.red, // Access 'IN' from orderItem
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
