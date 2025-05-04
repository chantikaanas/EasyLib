import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'services/auth_bridge.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  File? _image;
  final picker = ImagePicker();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final isAuth = await AuthBridge.isAuthenticated();
    if (!isAuth) {
      // If not authenticated, redirect to login
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
      return;
    }

    final user = await AuthBridge.getCurrentUser();
    if (mounted) {
      setState(() {
        userData = user;
        isLoading = false;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: getImage,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                    : AssetImage(
                                        'assets/images/profile/Profile.png') as ImageProvider,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 130,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: DataUser(
                          userData: userData!,
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class DataUser extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DataUser({super.key, required this.userData});

  @override
  State<DataUser> createState() => _DataUserState();
}

class _DataUserState extends State<DataUser> {
  void _showEditDialog(
      String title, String currentValue, Function(String) onSave) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit $title',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter new $title',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.white),
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Convert string date to DateTime if available, otherwise use defaults
    DateTime joinedDate;
    DateTime birthDate;

    try {
      joinedDate = widget.userData['created_at'] != null
          ? DateTime.parse(widget.userData['created_at'])
          : DateTime.now();
    } catch (e) {
      joinedDate = DateTime.now();
    }

    try {
      birthDate = widget.userData['date_of_birth'] != null
          ? DateTime.parse(widget.userData['date_of_birth'])
          : DateTime(2000, 1, 1);
    } catch (e) {
      birthDate = DateTime(2000, 1, 1);
    }

    final name = widget.userData['name'] ?? 'User';
    final email = widget.userData['email'] ?? 'email@example.com';
    final phone = widget.userData['phone_number'] ?? '';
    final address = widget.userData['address'] ?? '';

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(email,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal Bergabung',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(DateFormat('dd/MM/yyyy').format(joinedDate),
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal Lahir',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(DateFormat('dd/MM/yyyy').format(birthDate),
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
              child: GestureDetector(
            onTap: () {
              _showEditDialog(
                'Nomor Telepon',
                phone,
                (newValue) {
                  // Here you would typically update the data in your backend
                  print('Nomor Telepon: $newValue');
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nomor Telepon',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(phone,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(height: 20),
              ],
            ),
          )),
          Container(
              child: GestureDetector(
            onTap: () {
              _showEditDialog(
                'Alamat',
                address,
                (newValue) {
                  // Here you would typically update the data in your backend
                  print('Alamat: $newValue');
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alamat',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(address,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(height: 20),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
