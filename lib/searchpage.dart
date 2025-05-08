import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_lib/models/category.dart';
import 'package:easy_lib/services/catagories_handler.dart';
import 'package:easy_lib/booklist.dart'; // Adjust import path as needed

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Function to fetch categories
  void _fetchCategories() async {
    try {
      setState(() {
        isLoading = true;
      });
      
      List<Category> fetchedCategories = await CategoryService.getCategories();
      
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to navigate to BookListPage when user searches or selects a category
  void _navigateToBookList({String? searchQuery, int? categoryId, String? categoryName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookListPage(
          initialSearch: searchQuery,
          initialCategoryId: categoryId,
          initialCategoryName: categoryName,
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Search',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search input field
                  TextField(
                    controller: searchController,
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
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _navigateToBookList(searchQuery: value);
                      }
                    },
                  ),
                  
                  const SizedBox(height: 25),
                  buildSectionTitle('Pilih Kategori'),
                  const SizedBox(height: 10),
                  
                  // Horizontal scrollable categories
                  categories.isEmpty
                    ? Center(child: Text('No categories available'))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: _buildCategoryItem(
                                context,
                                category.icon,
                                category.nama_kategori,
                                category.id,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
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

  // Category item widget
  Widget _buildCategoryItem(
      BuildContext context, IconData icon, String label, int categoryId) {
    return InkWell(
      onTap: () {
        _navigateToBookList(
          categoryId: categoryId,
          categoryName: label,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}