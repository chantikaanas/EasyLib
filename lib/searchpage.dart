import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SearchScreen(), // Langsung masuk ke halaman SearchScreen untuk debugging
  ));
}

class SearchScreen extends StatelessWidget {
  final List<String> history = ["Bintang", "Nebula", "Hujan", "Matahari"];
  final List<String> trending = ["Bintang", "Nebula", "Hujan", "Matahari", "Bulan"];
  final List<Map<String, dynamic>> categories = [
    {'label': 'Sci-Fi', 'icon': Icons.rocket},
    {'label': 'Science', 'icon': Icons.school},
    {'label': 'Romance', 'icon': Icons.favorite},
    {'label': 'Horror', 'icon': Icons.mood_bad},
  ];

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 12), // Tambah jarak antara judul dan tombol kategori
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4, // Lebih lebar agar lebih nyaman
                crossAxisSpacing: 12, // Tambah jarak horizontal
                mainAxisSpacing: 12, // Tambah jarak vertikal
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Tambah padding
                  ),
                  onPressed: () {},
                  icon: Icon(categories[index]['icon'], size: 24), // Perbesar icon
                  label: Text(
                    categories[index]['label'],
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              },
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
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Tambah padding
              ))
          .toList(),
    );
  }
}
