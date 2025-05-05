import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:easy_lib/models/book.dart';

class BookService {
  static String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://localhost:8000/api';

  // Get all books with optional search and category filters
  static Future<List<Book>> getBooks({String? search, int? categoryId}) async {
    try {
      String url = '$baseUrl/books';

      // Add query parameters if provided
      final queryParams = <String, String>{};
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (categoryId != null) {
        queryParams['category_id'] = categoryId.toString();
      }

      if (queryParams.isNotEmpty) {
        url += '?' + Uri(queryParameters: queryParams).query;
      }

      print('Fetching books from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<dynamic> data;

        // Check if the response structure includes a 'data' field
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          data = responseData['data'];
        } else if (responseData is List) {
          data = responseData;
        } else {
          throw Exception('Unexpected API response format');
        }

        return data.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getBooks: $e');
      // Return sample data for development
      return _getSampleBooks();
    }
  }

  // Get book details by ID
  static Future<Book> getBookDetail(int id) async {
    try {
      print('Fetching book details for ID: $id');

      final response = await http.get(
        Uri.parse('$baseUrl/books/$id'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print('Book detail response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Extract book data based on API structure
        Map<String, dynamic> bookData;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          bookData = responseData['data'];
        } else if (responseData is Map<String, dynamic>) {
          bookData = responseData;
        } else {
          throw Exception('Unexpected API response format');
        }

        print('Book data received: ${bookData.keys}');
        return Book.fromJson(bookData);
      } else {
        throw Exception('Failed to load book details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getBookDetail: $e');
      // For testing or when API fails, return a sample book
      return _getSampleBook(id);
    }
  }

  // Helper method to get a sample book for testing or fallback
  static Book _getSampleBook(int id) {
    return Book(
      id: id,
      kodeBuku: 'BK00$id',
      kategoriId: 1,
      judul: 'Sample Book $id',
      pengarang: 'Sample Author',
      penerbit: 'Sample Publisher',
      tahunTerbit: '2023',
      stokBuku: 5,
      deskripsi:
          'This is a sample book description used when API calls fail or during development.',
      cover: 'assets/images/books/placeholder.png',
      kategori: {'nama_kategori': 'Sample Category'},
    );
  }

  // Get random recommendations (limited number of books)
  static Future<List<Book>> getRandomRecommendations({int limit = 5}) async {
    try {
      final books = await getBooks();

      if (books.isEmpty) {
        return _getSampleBooks();
      }

      // Shuffle the books to get random recommendations
      books.shuffle();

      // Return up to the requested limit
      return books.length <= limit ? books : books.sublist(0, limit);
    } catch (e) {
      print('Error in getRandomRecommendations: $e');
      return _getSampleBooks();
    }
  }

  // Provide sample books for development or when API fails
  static List<Book> _getSampleBooks() {
    print('Using sample books');
    return [
      Book(
        id: 1,
        kodeBuku: 'BK001',
        kategoriId: 1,
        judul: 'Bintang',
        pengarang: 'Tere Liye',
        penerbit: 'Gramedia',
        tahunTerbit: '2020-01-01',
        stokBuku: 10,
        deskripsi: 'Novel fantasi tentang petualangan',
        cover: 'assets/images/books/book1.png',
      ),
      Book(
        id: 2,
        kodeBuku: 'BK002',
        kategoriId: 1,
        judul: 'Bulan',
        pengarang: 'Tere Liye',
        penerbit: 'Gramedia',
        tahunTerbit: '2020-02-01',
        stokBuku: 8,
        deskripsi: 'Lanjutan dari novel Bintang',
        cover: 'assets/images/books/book2.png',
      ),
      Book(
        id: 3,
        kodeBuku: 'BK003',
        kategoriId: 1,
        judul: 'Bumi',
        pengarang: 'Tere Liye',
        penerbit: 'Gramedia',
        tahunTerbit: '2020-03-01',
        stokBuku: 5,
        deskripsi: 'Bagian dari serial novel fantasi',
        cover: 'assets/images/books/book3.png',
      ),
    ];
  }
}
