import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class QrValidationService {
  static String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://localhost:8000/api';

  static Future<bool> validateQrCode(String qrCode) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/detail/$qrCode'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['exists'] == true;
      }
      return false;
    } catch (e) {
      print('Error validating QR code: $e');
      return false;
    }
  }
}
