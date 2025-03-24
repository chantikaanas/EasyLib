import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<CategoryData> categories = [
  CategoryData(Icons.school, 'Science'),
  CategoryData(Icons.computer, 'Technology'),
  CategoryData(Icons.sports_soccer, 'Sports'),
  CategoryData(Icons.music_note, 'Music'),
  CategoryData(Icons.book, 'Novel'),
  CategoryData(Icons.rocket, 'Sci-Fi'),
  CategoryData(Icons.favorite, 'Romace'),
  CategoryData(Icons.mood_bad, 'Horror'),
  CategoryData(Icons.theater_comedy, 'Drama'),
];

class CategoryData {
  final IconData icon;
  final String title;

  CategoryData(this.icon, this.title);
}

final List<RecomendationData> recomendations = [
  RecomendationData('assets/images/books/book1.png', 'Bintang', 'Tere Liye'),
  RecomendationData('assets/images/books/book2.png', 'Bulan', 'Tere Liye'),
  RecomendationData('assets/images/books/book3.png', 'Bumi', 'Tere Liye'),
];

class RecomendationData {
  final String image;
  final String title;
  final String author;

  RecomendationData(this.image, this.title, this.author);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                const Header(),
                CategoriesSection(),
                RecomendationSection(),
                RecomendationSection(),
                RecomendationSection(),
                RecomendationSection(),
              ],
            )
          ],
        ),
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
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  print("Profile");
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      Image.asset('assets/images/profile/profile.png').image,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/search');
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 8),
                      Text("Baca buku apa hari ini?",
                          style: GoogleFonts.poppins(color: Colors.grey[400])),
                      Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(
                          Icons.settings,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: 20),
          // <--- Greetings Card --->
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        Image.asset('assets/images/profile/profile.png').image,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang,",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Asep Kurniawan!",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF3F84B6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/kartuanggota');
                  },
                  child: Center(
                    child: Text(
                      "Tunjukan Kartu Anggota",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CATEGORIES',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/search'); // BELUM DI ROUTE KE SEARCH
                  },
                  icon: Icon(Icons.more_horiz)),
            ],
          ),
        ),
        // <--- Categories List --->
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length, // Add categories list
            separatorBuilder: (context, index) => SizedBox(width: 16),
            itemBuilder: (context, index) {
              return CartegoryItem(
                categories[index].icon,
                categories[index].title,
              );
            },
          ),
        )
      ],
    );
  }
}

Widget CartegoryItem(IconData icon, String title) {
  return InkWell(
    onTap: () {
      print("Category: $title");
    },
    child: Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 52,
            color: Colors.black87,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget RecomendationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MUNGKIN KAMU SUKA',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () {
                  print("Buku Recomendation");
                },
                icon: Icon(Icons.more_horiz)),
          ],
        ),
      ),
      // <--- Recomendation List --->
      SizedBox(
        height: 170,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: recomendations.length, // Add categories list
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemBuilder: (context, index) {
            return RecomendationItem(
              recomendations[index].image,
              recomendations[index].title,
            );
          },
        ),
      )
    ],
  );
}

Widget RecomendationItem(String image, String title) {
  return InkWell(
    onTap: () {
      print("Recomendation: $title");
    },
    child: Container(
      width: 120,
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1)),
          ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )),
    ),
  );
}
