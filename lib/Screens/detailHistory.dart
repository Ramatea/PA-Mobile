import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';


class detailHistory extends StatelessWidget {
  final String Id;
  final DateTime date;
  final String  amount;
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
  final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your History'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top : 10, bottom: 5, left: 16, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Date: ${DateFormat('dd MMMM yyyy').format(date.toLocal())}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Category            : $category'),
              ),
              Divider(),
              ListTile(
                title: Text('Explanation       : $explanation'),
              ),
              Divider(),
              ListTile(
                 title: Text('Amount              : $amount'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}