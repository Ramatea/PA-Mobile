import 'package:flutter/material.dart';
import 'package:managment/Screens/add.dart';
import 'package:managment/Screens/home.dart';
import 'package:managment/Screens/statistics.dart';


class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screen = [Home(), Statistics(), Home(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: const Color.fromARGB(255, 82, 109, 130),
      //   title: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 20, left : 15),
      //       child: Text(
      //         "WalletWhiz", // Judul AppBar
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 25,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       // Tambahkan fungsi yang diinginkan saat tombol profil di tekan
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 20, left : 15),
      //       child: ClipOval(
      //         child: Container(
      //           color: Color.fromARGB(255, 221, 230, 237),
      //           // padding: EdgeInsets.all(0),
      //           child: Image.asset(
      //             'images/profile.jpg',
      //             height: 10,
      //             width: 10,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         // Tambahkan fungsi yang diinginkan saat tombol pengaturan di tekan
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 20,right: 15),
      //         child: Icon(
      //           Icons.settings,
      //           color: Colors.white,
      //           size: 30,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_Screen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 39, 55, 77),
      ),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color == 1 ? Color.fromARGB(255, 39, 55, 77) : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: index_color == 2 ? Color.fromARGB(255, 39, 55, 77) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
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
