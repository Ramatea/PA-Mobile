import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managment/Screens/historyPage.dart';

import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'detailHistory.dart'; 

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState(); 
}

class _HomeState extends State<Home> {
  var idUser = FirebaseAuth.instance.currentUser!.uid;
  
  Stream<QuerySnapshot> readData(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection('users')
        .snapshots();
        
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: readData(), 
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                  default :
                    if(snapshot.hasError){
                       return Center(
                         child:Text('Error while reading data!'),
                       );
                    } else {
                      if(snapshot.data?.docs.length == 0){
                        return Center(
                          child:Text('No history data available!',),
                        );
                    }else{
                      int panjang = snapshot.data!.docs.length;
                      int index = 0;
                      for(int i = 0;i < panjang;i++){
                        if(snapshot.data!.docs[i].id == idUser){
                          index = i;
                        }
                      }return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color.fromARGB(255, 100, 127, 148),
                  ),
                  height: tinggi * 0.32,
                  width: lebar,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Container(
                            color: themeProvider.primaryColor,
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'images/logo.png',
                              height: 45,
                              width: 45,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome,',
                                style: GoogleFonts.daiBannaSil(
                                  color: themeProvider.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                snapshot.data?.docs[index]['nama'],
                                style: GoogleFonts.daiBannaSil(
                                  color: themeProvider.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            final themeProvider =
                                Provider.of<ThemeProvider>(context, listen: false);
                            themeProvider.setThemeMode(
                              themeProvider.themeMode == ThemeModeType.light
                                  ? ThemeModeType.dark
                                  : ThemeModeType.light,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, right: 20),
                            child: Icon(
                              Icons.dark_mode_outlined,
                              color: themeProvider.textColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
                  child: Container(
                      height: tinggi * 0.25,
                      width: lebar,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 31, 46, 66).withOpacity(0.5),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: GoogleFonts.roboto(
                              color: themeProvider.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\Rp. ${snapshot.data?.docs[index]['balance']}',
                            style: TextStyle(
                              color: themeProvider.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor:
                                        const Color.fromARGB(255, 221, 230, 237),
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      color: Color.fromARGB(255, 39, 55, 77),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: themeProvider.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\Rp. ${snapshot.data?.docs[index]['income']}',
                                        style: TextStyle(
                                          color: themeProvider.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor:
                                        const Color.fromARGB(255, 221, 230, 237),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      color: Color.fromARGB(255, 39, 55, 77),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                          color: themeProvider.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\Rp. ${snapshot.data?.docs[index]['expenses']}',
                                        style: TextStyle(
                                          color: themeProvider.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
                    }
                  }
                }
              }),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transactions History',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: themeProvider.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => History()),
                      );
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: themeProvider.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: tinggi * 0.25,
              width: lebar,
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
                      child: Text('No history data available.'),
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
                        key: ValueKey<String>(Id), // Use a unique key for each ListTile
                        padding: const EdgeInsets.all(8),
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
        ),
      ),
    );
  }
}
