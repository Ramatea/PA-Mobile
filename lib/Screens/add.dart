import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Add_Screen extends StatefulWidget {
  final balance, expenses, income;
  const Add_Screen({Key? key, required this.balance, required this.expenses, required this.income});

  @override
  State<Add_Screen> createState() => _AddScreenState();
}

class _AddScreenState extends State<Add_Screen> {
  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedItemi;
  final TextEditingController explainController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<String> items = ['food', 'Transfer', 'Transportation', 'Education'];
  final List<String> itemsIncomeExpand = ['Income', 'Expand'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackgroundContainer(context, themeProvider),
            Positioned(
              top: 50,
              child: _buildMainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMainContainer() {
    var tinggi = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: tinggi * 0.80,
      width: 340,
      child: Column(
        children: [
          SizedBox(height: 50),
          name(),
          SizedBox(height: 30),
          explain(),
          SizedBox(height: 30),
          amount(),
          SizedBox(height: 30),
          how(),
          SizedBox(height: 30),
          dateTime(),
          SizedBox(height: 25),
          save(),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () async {
        _submitOrder();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 39, 55, 77),
        ),
        width: 100,
        height: 40,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  bool _submitOrder() {
    try {
      String explainValue = explainController.text;
      String amountValue = amountController.text;
      double totalBalance = 0;

      if (selectedItem == null && amountValue.isEmpty && explainValue.isEmpty && selectedItemi == null) {
        _showErrorDialog('kosong');
        return false;
      }

      if (selectedItem == null || selectedItemi == null) {
        _showErrorDialog('Please select menu');
        return false;
      }

      if (totalBalance <= 0 && selectedItemi == 'Expense') {
        _showErrorDialog('You cannot incur expenses when the total balance is 0!');
        return false;
      }

      if (amountValue.isEmpty) {
        _showErrorDialog('Please enter a valid amount!');
        return false;
      }

      if (explainValue.isEmpty || explainValue.length > 50) {
        _showErrorDialog('Please enter a valid explanation (max 50 characters)!');
        return false;
      }

      Map<String, dynamic> data = {
        'itemType': selectedItem!,
        'amount': amountValue,
        'date': Timestamp.fromDate(date),
        'explanation': explainValue,
        'category': selectedItemi!,
      };

      if (selectedItemi! == 'Expand') {
        int amount = int.parse(amountValue);
        if (widget.balance - amount < 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Your balance is not enough!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          _saveDataToFirebase(data);
          _updateFields(selectedItemi!, amount);
        }
      } else {
        _saveDataToFirebase(data);
        _updateFields(selectedItemi!, int.parse(amountValue));
      }
      return true;
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again!');
      return false;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _saveDataToFirebase(Map<String, dynamic> data) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('History').add(data);

      _showSuccessDialog('Data saved successfully!');
    } catch (e) {
      _showErrorDialog('Failed to save data. Please try again.');
    }
  }

  void _updateFields(String category, int value) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    int saldo = widget.balance;
    int newExp = widget.expenses;
    int newInc = widget.income;
    if (category == 'Expand') {
      saldo = widget.balance - value;
      newExp = newExp + value;
    } else {
      saldo = widget.balance + value;
      newInc = newInc + value;
    }
    final data = {
      "balance": saldo,
      "expenses": newExp,
      "income": newInc,
    };
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('users').doc(id).update(data).then((DocumentSnapshot) => print('Berhasil dengan id : $id'));
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clear();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void clear() {
    selectedItem = null;
    selectedItemi = null;
    explainController.clear();
    amountController.clear();
    setState(() {});
  }

  Widget dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffC5C5C5)),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding how() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItemi,
          onChanged: ((value) {
            setState(() {
              selectedItemi = value!;
            });
          }),
          items: itemsIncomeExpand
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => itemsIncomeExpand
              .map((e) => Row(
                    children: [Text(e)],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'How',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(
        decimal: false, signed: false),
        inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,],
        controller: amountController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: const Color.fromARGB(255, 39, 55, 77),),
          ),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: explainController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'explain',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: const Color.fromARGB(255, 39, 55, 77),),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          onChanged: ((value) {
            setState(() {
              selectedItem = value!;
            });
          }),
          items: items
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Image.asset('images/$e.png'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => items
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('images/$e.png'),
                      ),
                      SizedBox(width: 5),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Name',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Column _buildBackgroundContainer(BuildContext context, ThemeProvider themeProvider) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;


    return Column(
      children: [
        Container(
          width: lebar,
          height: tinggi * 0.25,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 100, 127, 148),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Adding',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
