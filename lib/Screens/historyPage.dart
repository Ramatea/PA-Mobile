import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'detailHistory.dart'; // Import your DetailHistory page file

class History extends StatefulWidget {
  @override
  State<History> createState() => _HomeState(); // Fix the class name here
}

class _HomeState extends State<History> {
  var idUser = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> readData() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection('users')
      .doc(idUser)
      .collection('History')
      .orderBy('date', descending: true) 
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.textColor,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 100, 127, 148),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: themeProvider.backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Color.fromARGB(255, 100, 127, 148),
              ),
              height: tinggi * 0.03,
              width: lebar,
            ),
            
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: readData(), 
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting: {
                    return Center(child: CircularProgressIndicator());
                  }
                  default: {
                    if(snapshot.hasError){
                       return Center(
                         child:Text('Error while reading data!'),
                       );
                    } else {
                      if(snapshot.data?.docs.length == 0){
                        return Center(
                          child:Text('No history data available!',),
                        );
                      } else {
                        int panjang = snapshot.data!.docs.length;
                        for(int i = 0; i < panjang; i++){
                          if(snapshot.data!.docs[i].id == idUser){
                          }
                        }
                        return Column(
                          children: [
                            Container(
                              height: 235,
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user?.uid)
                                    .collection('History')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  }
                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: Text('No history data available'),
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
                                        key: ValueKey<String>(Id),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: ListTile(
                                            leading: Container(
                                              width: 40,
                                              child: Image.asset('images/$itemType.png'),
                                            ),
                                            title: Text(category),
                                            subtitle: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      DateFormat('dd MMMM yyyy').format(date.toDate()), 
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          '${category == 'Income' ? '+' : '-'} Rp. $amount',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: category == 'Income' ? Colors.green : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onTap: () {
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
                            ),
                          ],
                        );
                      }
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
