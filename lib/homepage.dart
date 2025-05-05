import 'package:easy_lib/models/category.dart';
import 'package:easy_lib/services/auth_bridge.dart';
import 'package:easy_lib/services/catagories_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// <-------- DATA -------->
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
// <-------- END DATA -------->

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
                Header(),
                CategoriesSection(),
                RecommendationSection()
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
  String userName = '';
  String? profilePicture;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await AuthBridge.getCurrentUser();
      if (userData != null && mounted) {
        setState(() {
          userName = userData['name'] ?? 'User';
          profilePicture = userData['profile_picture'];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        userName = 'User';
        isLoading = false;
      });
    }
  }

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
                  Navigator.of(context).pushNamed('/profile');
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: profilePicture != null
                      ? NetworkImage(profilePicture!)
                      : AssetImage('assets/images/profile/Profile.png')
                          as ImageProvider,
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
                      backgroundImage: profilePicture != null
                          ? NetworkImage(profilePicture!)
                          : AssetImage('assets/images/profile/Profile.png')),
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
                        isLoading ? "Loading . . ." : "$userName!",
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
  List<Category> categories = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final loadedCategories = await CategoryService.getCategories();
      setState(() {
        categories = loadedCategories;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
              final category = categories[index];
              return CategoryItem(
                  icon: category.icon, title: category.nama_kategori);
            },
          ),
        )
      ],
    );
  }
}

class CategoryItem extends StatefulWidget {
  final IconData icon;
  final String title;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/search',
            arguments: widget.title); // BELUM DI ATUR KE SEARCH DAN FILLTER
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
              widget.icon,
              size: 52,
              color: Colors.black87,
            ),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendationSection extends StatefulWidget {
  const RecommendationSection({super.key});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
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
                image: recomendations[index].image,
                title: recomendations[index].title,
              );
            },
          ),
        )
      ],
    );
  }
}

class RecomendationItem extends StatefulWidget {
  final String image;
  final String title;

  const RecomendationItem({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  State<RecomendationItem> createState() => _RecomendationItemState();
}

class _RecomendationItemState extends State<RecomendationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/bookdetails', arguments: widget.title);
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
              widget.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
