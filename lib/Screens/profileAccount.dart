import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:managment/Screens/home.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:managment/widgets/loginpage.dart';
import 'package:managment/widgets/profile_edit.dart';
// import 'package:managment/widgets/profile_edit.dart';
import 'package:provider/provider.dart';

class profileAccountScreens extends StatelessWidget { 
  Stream<QuerySnapshot> getData(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection('users')
    .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
       appBar: AppBar(
        title: Text('Profile Account',
        style: TextStyle(
        color: themeProvider.textColor,
        ),
        ),
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back, 
          color: themeProvider.textColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        
        backgroundColor:  Color.fromARGB(255, 151, 162, 177),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                  stream: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }else if (snapshot.hasError){
                          return Text('Error: ${snapshot.error}');
                        }else{
                          var id = FirebaseAuth.instance.currentUser!.uid;
                          int panjang = snapshot.data!.docs.length;
                          int index = 0;
                          for(int i = 0;i < panjang; i++){
                            if(snapshot.data!.docs[i].id == id){
                              index = i;
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: screenWidth < 600 ? 60 : 80,
                                backgroundColor: const Color.fromARGB(255, 31, 29, 29),
                                // backgroundImage: userData?['profileImageUrl'] !=
                                //         null
                                //     ? NetworkImage(userData?["https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250"])
                                //         as ImageProvider<Object>?
                                //     : 
                                backgroundImage: Image.asset('images/settingprofile.png').image,
                              ),
                              SizedBox(height: 10),
                              // Text(
                              //   userData?['name'] ??
                              //   '',
                              //   style: TextStyle(
                              //   fontSize: screenWidth < 600 ? 18 : 24,
                              //   fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                                Text(
                                  snapshot.data?.docs[index]['nama'],
                                  style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 18,
                                color: themeProvider.textColor,
                                ),
                                ),
                                Text(
                                  snapshot.data?.docs[index]['email'], 
                                  style: TextStyle(
                                      fontSize: screenWidth < 600 ? 16 : 18,
                                      color: themeProvider.textColor,),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                leading: Icon(Icons.person, 
                color: themeProvider.textColor,),
                title: Text('Profile', 
                style: TextStyle(
                color: themeProvider.textColor,),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEditPage()),
                  );
                },
              ),
              
                ListTile(
                leading: Icon(Icons.exit_to_app,
                color: themeProvider.textColor,),
                title: Text('Sign Out',
                style: TextStyle(
                color: themeProvider.textColor,),),
          
                onTap: () {
                  // Fungsi untuk logout
                  _LogOut(context);
                },
                  ),
              ],
            ),
          
            

          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => Home()));
          //   },
          //     child: Icon(Icons.add),
          //     backgroundColor: Color.fromARGB(255, 46, 68, 97),
          //     ),
    );
              // child: Text(
              // 'Back',
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // );
   
  }
    Future<void> _LogOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Sign Out'),
          content: Text('Anda Yakin ingin keluar?'),
          backgroundColor: Color.fromARGB(255, 164, 189, 209),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Lakukan sign-out dan kembali ke halaman login
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      // Melakukan logout dari Firebase Authentication
      await FirebaseAuth.instance.signOut();
      // Pindahkan pengguna ke halaman lain setelah logout berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      print('Error during logout: $e');
      // Menampilkan pesan kesalahan jika diperlukan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: $e'),
        ),
      );
    }
  }
}