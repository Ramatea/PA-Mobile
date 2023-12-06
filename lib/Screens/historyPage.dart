// Import paket-paket yang diperlukan
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Halaman untuk menampilkan riwayat pesanan pengguna
class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dapatkan informasi pengguna yang sedang login
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
              var orderItem = historyDocs[index];
              String orderId = orderItem.id;
              Timestamp date = orderItem['date'] as Timestamp;
              String amount = orderItem['amount'];
              String category = orderItem['category'];
              String explanation = orderItem['explanation'];
              String itemType = orderItem['itemType'];                          

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('Histroy ID: $orderId'),                    
                    onTap: () {
                      // Menampilkan pop-up dengan detail lengkap pesanan
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Order Details'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: ${date.toDate()}'),
                                Text('Amount: $amount'),
                                Text('Category: $category'),                                
                                Text('Explanation: $explanation'),                                
                                Text('itemType: $itemType'),                                
                                Text(''),                                
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
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