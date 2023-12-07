import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managment/Screens/passChange.dart';
//import 'package:managment/data/model/manage.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:managment/widgets/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
//import 'package:intro_views_flutter/intro_views_flutter.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
    Uint8List? _pickedImageBytes;
    String? _imageUrl;
    String? _previousImageUrl;
   // final introKey = GlobalKey<IntroViewsFlutterState>();

    Future<void> _uploadImage(Uint8List imageBytes) async {

    try{
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String imageName = 'profile_images/$userId.png';
      Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('imageName');
      UploadTask uploadTask = storageReference.putData(imageBytes);
      await  uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseAuth.instance.currentUser
        ?.updateProfile(photoURL: imageUrl);

      print('Data berhasil disimpan');
    }catch (e) {
     print('Error saving changes: $e');
    }
    }

    Future<void> _pickImage() async {
    _previousImageUrl = _imageUrl;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final Uint8List uint8List = Uint8List.fromList(imageBytes);

      setState(() {
        _pickedImageBytes = uint8List;
      });
      await _uploadImage(uint8List);
    }
  }

 Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    Future<void> deleteAccount() async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
          print("User account deleted.");
        } else {
          print("No user signed in.");
        }
      } catch (e) {
        print("Error deleting account: $e");
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Account"),
          content: Text(
              "Apakah Anda Yakin Ingin Menghapus Akun Anda?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await deleteAccount();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
 
  @override
   void initState() {
    super.initState();
    _imageUrl = FirebaseAuth.instance.currentUser?.photoURL;
  }
  
  @override
  Widget build(BuildContext context) {
    if (_imageUrl != _previousImageUrl) {
      _previousImageUrl = _imageUrl;
    }
    final themeProvider = Provider.of<ThemeProvider>(context);
    //final dataManager = Provider.of<DataManage>(context); 
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 156, 148, 148),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: _pickedImageBytes != null
                          ? Image.memory(_pickedImageBytes!,
                              fit: BoxFit.cover, width: 140, height: 140)
                          : _imageUrl != null
                              ? Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading image: $error');
                                    print(
                                        'Image URL from Firebase: $_imageUrl');
                                    return Image.network(
                                        'images/settingprofile.png',
                                        fit: BoxFit.cover,
                                        width: 140,
                                        height: 140);
                                  },
                                )
                              : Image.network('images/settingprofile.png',
                                  fit: BoxFit.cover, width: 140, height: 140),
                    ),
                  ),
                  Container(
                    //color: Colors.grey[800],
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 6, 51, 88),
                    ),
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                      tooltip: 'Edit Picture',
                    ),
                  ),
                ],
              ),
            ),
             SettingsGroup(
               items: [

              ],
            ),
   
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => passChange()));
                  },
                  icons: CupertinoIcons.repeat,
                  title: "Change Password",
                ),
                SettingsItem(
                  onTap: () async {
                    showDeleteConfirmationDialog(context);
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
          ],
        ),
      ),
      );
  }
}