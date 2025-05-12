import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'auth_bridge.dart';

class PeminjamanService {
  static String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://localhost:8000/api';

  static Future<List<Map<String, dynamic>>> getBorrowedBooks() async {
    try {
      final token = await AuthBridge.getToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/peminjaman'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'success' && data['data'] != null) {
          return List<Map<String, dynamic>>.from(data['data']);
        }
      }
      throw Exception(data['message'] ?? 'Failed to load borrowed books');
    } catch (e) {
      print('Error fetching borrowed books: $e');
      return [];
    }
  }

  static Future<bool> returnBook(int borrowId) async {
    try {
      final token = await AuthBridge.getToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/peminjaman/$borrowId/return'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = json.decode(response.body);
      return response.statusCode == 200 && data['status'] == 'success';
    } catch (e) {
      print('Error returning book: $e');
      return false;
    }
  }
}
