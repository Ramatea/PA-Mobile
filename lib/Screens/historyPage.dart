import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'detailHistory.dart'; // Import your DetailHistory page file

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your History'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('History')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> historyDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: historyDocs.length,
            itemBuilder: (context, index) {
              var historyItem = historyDocs[index];
              String Id = historyItem.id;
              Timestamp date = historyItem['date'] as Timestamp;
              String amount = historyItem['amount'];
              String category = historyItem['category'];
              String explanation = historyItem['explanation'];
              String itemType = historyItem['itemType'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      child: Image.asset('images/$itemType.png'),
                    ),
                    title: Text(category),
                   subtitle: Text(
                      DateFormat('dd MMMM yyyy').format(date.toDate()), 
                      style: TextStyle(
                        fontSize: 12,
                      ),// Format the date
                    ),
                    onTap: () {
                      // Pass the relevant data to the DetailHistory page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detailHistory(
                            Id: Id,
                            date: date.toDate(),
                            amount: amount,
                            category: category,
                            explanation: explanation,
                            itemType: itemType,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
