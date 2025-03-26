import 'package:easy_lib/homepage.dart';
import 'package:easy_lib/profilePage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            selected = index;
          });
        },
        children: [
          Center(
            child: HomePage(),
          ),
          Center(
            child: Text('Scan Qr'), // Nanti ganti ke FaQ
          ),
          Center(
            child: ProfilePage(), // Nanti ganti ke FaQ
          ),
          Center(
            child: Text('FaQ'), // Nanti ganti ke Profile
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: 'FaQ',
          ),
        ],
      ),
    );
  }
}
