import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
        SearchScreen(), // Langsung masuk ke halaman SearchScreen untuk debugging
  ));
}

class SearchScreen extends StatelessWidget {
  final List<String> history = ["Bintang", "Nebula", "Hujan", "Matahari"];
  final List<String> trending = [
    "Bintang",
    "Nebula",
    "Hujan",
    "Matahari",
    "Bulan"
  ];
  final List<Map<String, dynamic>> categories = [
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
    {'label': 'Mystery', 'icon': Icons.help_outline},
    {'label': 'Thriller', 'icon': Icons.psychology},
    {'label': 'Poetry', 'icon': Icons.auto_stories},
    {'label': 'Self-Help', 'icon': Icons.emoji_objects},
  ];

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Distribute items between rows (alternating)
    List<List<Map<String, dynamic>>> rowData = [[], []];
    for (int i = 0; i < categories.length; i++) {
      rowData[i % 2].add(categories[i]);
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, size: 28), // Perbesar icon
        title: Text(
          'Search',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 24),
                hintText: 'Telusuri koleksi',
                hintStyle: GoogleFonts.poppins(fontSize: 16),
                suffixIcon: const Icon(Icons.filter_list, size: 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),

            // Tambahkan jarak sebelum judul "Riwayat Anda"
            const SizedBox(height: 25),
            buildSectionTitle('Riwayat Anda'),
            const SizedBox(height: 10), // Tambah jarak antara judul dan isi
            buildChips(history),

            // Tambahkan jarak sebelum judul "Cari Kategori"
            const SizedBox(height: 30),
            buildSectionTitle('Cari Kategori'),
            const SizedBox(
                height: 12), // Tambah jarak antara judul dan tombol kategori

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: categories
                        .sublist(0, categories.length ~/ 2)
                        .map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: _buildCategoryItem(
                            category['icon'], category['label']),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10), // Jarak antar baris
                  Row(
                    children: categories
                        .sublist(categories.length ~/ 2)
                        .map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: _buildCategoryItem(
                            category['icon'], category['label']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Tambahkan jarak sebelum judul "Pencarian Trending"
            const SizedBox(height: 35),
            buildSectionTitle('Pencarian Trending'),
            const SizedBox(height: 10), // Tambah jarak antara judul dan isi
            buildChips(trending),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildChips(List<String> items) {
    return Wrap(
      spacing: 10, // Tambah jarak antar chip
      runSpacing: 8, // Tambah jarak antar baris chip
      children: items
          .map((item) => Chip(
                label: Text(
                  item,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8), // Tambah padding
              ))
          .toList(),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20), // Ukuran icon disesuaikan agar sejajar
          const SizedBox(width: 8), // Jarak antara icon dan teks
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
