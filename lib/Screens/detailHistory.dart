import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class detailHistory extends StatelessWidget {
  final String Id;
  final DateTime date;
  final String amount;
  final String category;
  final String explanation;
  final String itemType;

  detailHistory({
    required this.Id,
    required this.date,
    required this.amount,
    required this.category,
    required this.explanation,
    required this.itemType,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Your History'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: 40,
            child: Image.asset('images/$itemType.png'),
          ),
          Text('Order ID: $Id'),
          Text('Date: $date'),
          Text('Amount: $amount'),
          Text('Category: $category'),
          Text('Explanation: $explanation'),
          Text('Item Type: $itemType'),
        ],
      ),
    );
  }
}
