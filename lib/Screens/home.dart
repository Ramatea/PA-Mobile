import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:managment/data/model/add_date.dart';
import 'package:managment/data/utlity.dart';

  class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 230, 237),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 400),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: const Color.fromARGB(255, 82, 109, 130),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 30), // Sesuaikan dengan posisi yang diinginkan
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Color.fromARGB(255, 221, 230, 237),
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'images/logo.png',
                              height: 45,
                              width: 45,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 95,
                    child: Text(
                      'Welcome,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 95,
                    child: Text(
                      'user!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 30,
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top :110, bottom: 330, left :  30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5)
              ),
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 20,
                    child: Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 20,
                    child: Text(
                      '\$ ${total()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 20,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor:
                          Color.fromARGB(255, 221, 230, 237),
                      child: Icon(
                        Icons.arrow_downward,
                        color: const Color.fromARGB(255, 39, 55, 77),
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 88,
                    left: 50,
                    child: Text(
                      'Income',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 50,
                    child: Text(
                      '\$ ${income()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    right: 95,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor:
                          Color.fromARGB(255, 221, 230, 237),
                      child: Icon(
                        Icons.arrow_upward,
                        color: const Color.fromARGB(255, 39, 55, 77),
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 88,
                    right: 20,
                    child: Text(
                      'Expenses',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: 40,
                    child: Text(
                      '\$ ${expenses()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270, left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions History',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300, bottom: 100, left: 15, right: 15),
            child: Container(
              height: 140,
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  history = box.values.toList()[index];
                  return getList(history, index);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 450, bottom: 20, left: 30, right: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/1.jpg', // Replace with the actual path to your image asset
                        width: 200,
                        height: 105,
                        fit: BoxFit.cover, // Adjust the BoxFit property as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    width: 200,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/1.jpg', // Replace with the actual path to your image asset
                        width: 200,
                        height: 105,
                        fit: BoxFit.cover, // Adjust the BoxFit property as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    width: 200,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/1.jpg', // Replace with the actual path to your image asset
                        width: 200,
                        height: 105,
                        fit: BoxFit.cover, // Adjust the BoxFit property as needed
                      ),
                    ),
                  ),
                ]
              ),  
            ),
          )
        ],
      ),
    );
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
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
    );
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
      key: UniqueKey(),
      
      onDismissed: (direction) {
        history.delete();
        setState(() {});
      },
     child: get(index, history), 
    );
    
  }
}