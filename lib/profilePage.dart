import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _profilePageState();
}

class _profilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(children: [
          Center(
            child: Header(),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ListView(
                  children: [
                    Column(children: [
                      BookCard(),
                      SizedBox(height: 10),
                      BookCard(),
                      SizedBox(height: 10),
                      BookCard(),
                      SizedBox(height: 10),
                      BookCard(),
                      SizedBox(height: 10),
                    ])
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Column(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    Image.asset('assets/images/profile/profile.png').image,
              ),
              SizedBox(height: 10),
              Text(
                'Asep Kurniawan',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Member Sejak 2025',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  print('Ubah Profil');
                  //Navigator.pushNamed(context, '/editprofile');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 118, 210, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Ubah Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: Color.fromRGBO(25, 118, 210, 1),
                  ),
                  Text(
                    'Buku Terpinjam',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/images/books/book1.png', width: 105),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bintang',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tere Liye',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Tahun Terbit: 2015',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Batas Pengembalian ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '12/Jan/2026',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}
