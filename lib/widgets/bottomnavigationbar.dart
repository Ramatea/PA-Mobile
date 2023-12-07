import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:managment/Screens/add.dart';
import 'package:managment/Screens/home.dart';
import 'package:managment/Screens/profileAccount.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screen = [Home(), profileAccountScreens(),];


  Stream<QuerySnapshot> fetchData(){
    return FirebaseFirestore.instance
      .collection('users')
      .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: 
      StreamBuilder<QuerySnapshot>(
        stream: fetchData(), 
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(),);
            default :
            if(snapshot.hasError){
              return Text('Error saat membaca data');
            }else{
              if(snapshot.data!.docs.length == 0){
                return Text('Data Masih Kosong');
              }else{
                int index = 0;
                int panjang = snapshot.data!.docs.length;
                var id = FirebaseAuth.instance.currentUser!.uid;
                for(int i = 0; i < panjang; i++){
                  if(snapshot.data!.docs[i].id == id){
                    index = i;
                  }
                }
                return FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_Screen(balance: snapshot.data?.docs[index]['balance'],expenses: snapshot.data?.docs[index]['expenses'],income: snapshot.data?.docs[index]['income'],)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 31, 46, 66),

      );
              }
            }
          }
        }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0 ? Color.fromARGB(255, 39, 55, 77) : Colors.grey,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: index_color == 3 ? Color.fromARGB(255, 39, 55, 77) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
