import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookListPage(),
    );
  }
}

class BookListPage extends StatefulWidget {
  final String? initialCategory;

  const BookListPage({super.key, this.initialCategory});
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  int selectedCategoryIndex = 0;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Handle initial category if provided
    if (widget.initialCategory != null) {
      selectedCategoryIndex = categories.indexWhere(
          (category) => category['label'] == widget.initialCategory);
      if (selectedCategoryIndex == -1) selectedCategoryIndex = 0;
    }

    // Add search listener
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  final List<Map<String, dynamic>> books = [
    {
      'title': 'Bintang',
      'author': 'Tere Liye',
      'year': '2017',
      'isbn': '004123901233',
      'image': 'assets/images/books/book1.png',
      'categories': ['Sci-Fi', 'Fantasy']
    },
    {
      'title': 'Bulan',
      'author': 'Tere Liye',
      'year': '2017',
      'isbn': '004123901235',
      'image': 'assets/images/books/book2.png',
      'categories': ['Science']
    },
    {
      'title': 'Bumi',
      'author': 'Tere Liye',
      'year': '2017',
      'isbn': '004123901233',
      'image': 'assets/images/books/book3.png',
      'categories': ['Romance', 'Drama']
    },
    {
      'title': 'Nebula',
      'author': 'Tere Liye',
      'year': '2018',
      'isbn': '004123901111',
      'image': 'assets/images/books/book1.png',
      'categories': ['Sci-Fi']
    },
    {
      'title': 'Sains dalam Berita',
      'author': 'Ridwan Abdullah Sani',
      'year': '2020',
      'isbn': '004123901112',
      'image': 'assets/images/books/book2.png',
      'categories': ['Science']
    },
    {
      'title': 'Dilan 1990',
      'author': 'Pidi Baiq',
      'year': '2014',
      'isbn': '004123901113',
      'image': 'assets/images/books/book3.png',
      'categories': ['Romance']
    },
    {
      'title': 'Gerbang Dialog Danur',
      'author': 'Risa Saraswati',
      'year': '2011',
      'isbn': '004123901114',
      'image': 'assets/images/books/book1.png',
      'categories': ['Horror']
    },
    {
      'title': 'Ronggeng Dukuh Paruk',
      'author': 'Ahmad Tohari',
      'year': '1982',
      'isbn': '004123901115',
      'image': 'assets/images/books/book2.png',
      'categories': ['Drama']
    },
    {
      'title': 'Harry Potter dan Batu Bertuah',
      'author': 'J.K. Rowling (Terjemahan)',
      'year': '2001',
      'isbn': '004123901116',
      'image': 'assets/images/books/book3.png',
      'categories': ['Fantasy']
    },
    {
      'title': 'Bung Karno: Penyambung Lidah Rakyat',
      'author': 'Cindy Adams',
      'year': '1965',
      'isbn': '004123901117',
      'image': 'assets/images/books/book1.png',
      'categories': ['Biography']
    },
    {
      'title': 'Sejarah Indonesia Modern',
      'author': 'MC Ricklefs',
      'year': '2001',
      'isbn': '004123901118',
      'image': 'assets/images/books/book2.png',
      'categories': ['History']
    },
    {
      'title': '5 cm',
      'author': 'Donny Dhirgantoro',
      'year': '2005',
      'isbn': '004123901119',
      'image': 'assets/images/books/book3.png',
      'categories': ['Adventure']
    },
    {
      'title': 'Koala Kumal',
      'author': 'Raditya Dika',
      'year': '2015',
      'isbn': '004123901120',
      'image': 'assets/images/books/book1.png',
      'categories': ['Comedy']
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.category}, // Default: Show all books
    {'label': 'Sci-Fi', 'icon': Icons.rocket},
    {'label': 'Science', 'icon': Icons.school},
    {'label': 'Romance', 'icon': Icons.favorite},
    {'label': 'Horror', 'icon': Icons.mood_bad},
    {'label': 'Drama', 'icon': Icons.theater_comedy},
    {'label': 'Fantasy', 'icon': Icons.auto_fix_high},
    {'label': 'Biography', 'icon': Icons.person},
    {'label': 'History', 'icon': Icons.history},
    {'label': 'Adventure', 'icon': Icons.explore},
    {'label': 'Comedy', 'icon': Icons.sentiment_very_satisfied},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔍 Filter books based on selected category and search query
    List<Map<String, dynamic>> filteredBooks = books.where((book) {
      bool matchesCategory = selectedCategoryIndex == 0 ||
          book['categories']
              .contains(categories[selectedCategoryIndex]['label']);
      bool matchesSearch = book['title'].toLowerCase().contains(searchQuery) ||
          book['author'].toLowerCase().contains(searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'List Buku',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Telusuri Koleksi',
                hintStyle: GoogleFonts.poppins(),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),

            // 📜 Scrollable Category Section
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Row(
                          children: [
                            Icon(categories[index]['icon'], size: 18),
                            SizedBox(width: 5),
                            Text(categories[index]['label']),
                          ],
                        ),
                        selected: selectedCategoryIndex == index,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                        selectedColor: Colors.blue.shade100,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: selectedCategoryIndex == index
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            SizedBox(height: 10),

            // 📚 Book List
            Expanded(
              child: filteredBooks.isEmpty
                  ? Center(
                      child: Text(
                        'No books available in this category',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredBooks.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, index) {
                        return _bookItem(filteredBooks[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookItem(Map<String, dynamic> book) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(book['image']!, height: 180, fit: BoxFit.cover),
      ),
      title: Text(
        book['title']!,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book['author']!,
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          Text(
            'Tahun Terbit: ${book['year']}',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          Text(
            book['isbn']!,
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
