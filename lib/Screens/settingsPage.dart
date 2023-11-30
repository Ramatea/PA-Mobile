import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 39, 55, 77),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 254, 254, 255).withOpacity(0.5),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 221, 230, 237),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
             Container(
              color: Color.fromARGB(255, 221, 230, 237),
              
              padding: EdgeInsets.all(8),
              child:
              Row(
                  children: [
                    Icon(
                      Icons.person,
                      color:const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "MyAccount",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
             ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            SizedBox(
              height: 40,
            ),
            Container(
              color: Color.fromARGB(255, 221, 230, 237),
              
              padding: EdgeInsets.all(8),
              child: Row(
              children: [
                // Icon(
                //   Icons.volume_up_outlined,
                //   color: const Color.fromARGB(255, 39, 55, 77).withOpacity(0.5),
                // ),
                // SizedBox(
                //   width: 8,
                // ),
                // Text(
                //   "Notifications",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor:const Color.fromARGB(255, 39, 55, 77),
                ),
              
                child: Text(
                "SIGN OUT",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2.2,
                  color: const Color.fromARGB(255, 241, 238, 238)),
              ),
              ),
              ],
            ),
            ),
          ],
        ),
      ), 
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
            return SimpleDialog(
            title: Text(title),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  // Logika untuk menanggapi opsi pertama
                  Navigator.of(context).pop();
                },
                child: Text("Username"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // Logika untuk menanggapi opsi kedua
                  Navigator.of(context).pop();
                },
                child: Text("Email"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // Logika untuk menanggapi opsi ketiga
                  Navigator.of(context).pop();
                },
                child: Text("Password"),
              ),
            ],
          );
        },
      );
    },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Color.fromARGB(255, 221, 230, 237),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
      ),
      ),
    );
  }
}