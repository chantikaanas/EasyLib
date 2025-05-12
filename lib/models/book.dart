import 'dart:io' show Platform;

class Book {
  final int id;
  final String kodeBuku;
  final int kategoriId;
  final String judul;
  final String pengarang;
  final String penerbit;
  final String tahunTerbit;
  final int stokBuku;
  final String deskripsi;
  final String? cover;
  final String? coverUrl;
  final dynamic kategori;
  final String? createdAt;
  final String? updatedAt;

  Book({
    required this.id,
    required this.kodeBuku,
    required this.kategoriId,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
    required this.stokBuku,
    required this.deskripsi,
    this.cover,
    this.coverUrl,
    this.kategori,
    this.createdAt,
    this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    try {
      return Book(
        id: json['id'] is String ? int.parse(json['id']) : json['id'],
        kodeBuku: json['kode_buku'] ?? '',
        kategoriId: json['kategori_id'] is String
            ? int.parse(json['kategori_id'])
            : json['kategori_id'] ?? 0,
        judul: json['judul'] ?? '',
        pengarang: json['pengarang'] ?? '',
        penerbit: json['penerbit'] ?? '',
        tahunTerbit: json['tahun_terbit']?.toString() ?? '',
        stokBuku: json['stok_buku'] is String
            ? int.parse(json['stok_buku'])
            : json['stok_buku'] ?? 0,
        deskripsi: json['deskripsi'] ?? '',
        cover: json['cover'],
        coverUrl: json['cover_url'],
        kategori: json['kategori'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
    } catch (e) {
      print('Error parsing Book from JSON: $e');
      print('Problem with JSON: $json');
      throw FormatException('Book parsing failed: $e', json);
    }
  }

  // String getImageUrl() {
  //   try {
  //     final baseUrl =
  //         Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000';

  //     // First priority: complete URL in coverUrl
  //     if (coverUrl != null && coverUrl!.isNotEmpty) {
  //       final cleanUrl = coverUrl!.trim();

  //       // If it's already a complete URL starting with http
  //       if (cleanUrl.startsWith('http')) {
  //         print('Using complete coverUrl: $cleanUrl');
  //         return cleanUrl;
  //       }

  //       // Handle relative storage URL
  //       if (cleanUrl.startsWith('/storage/')) {
  //         final url = '$baseUrl$cleanUrl';
  //         print('Using storage URL: $url');
  //         return url;
  //       }

  //       // Handle other relative URLs
  //       final url = '$baseUrl/storage/$cleanUrl';
  //       print('Using constructed URL: $url');
  //       return url;
  //     }

  //     // Second priority: cover filename
  //     if (cover != null && cover!.isNotEmpty) {
  //       final cleanCover = cover!.trim();
  //       final url = '$baseUrl/storage/img/books/cover/$cleanCover';
  //       print('Using cover URL: $url');
  //       return url;
  //     }

  //     // Fallback to default image
  //     print('Using default image');
  //     return 'assets/images/books/missing_cover.jpeg';
  //   } catch (e) {
  //     print('Error in getImageUrl: $e');
  //     return 'assets/images/books/missing_cover.jpeg';
  //   }
  // }

  String getImageUrl() {
    try {
      // Only use coverUrl if it's a complete URL and not empty
      if (coverUrl != null &&
          coverUrl!.isNotEmpty &&
          coverUrl!.startsWith('http')) {
        return coverUrl!;
      }

      // Only use cover if it looks like a valid path and doesn't contain local asset paths
      if (cover != null &&
          cover!.isNotEmpty &&
          !cover!.contains('assets/images')) {
        // If cover path looks like a server path (not a local asset path)
        if (!cover!.startsWith('http')) {
          // Construct a server URL
          return 'http://localhost:8000/storage/covers/$cover';
        }
        return cover!;
      }

      // If we reach here, use the default missing cover image
      return 'assets/images/books/missing_cover.jpeg';
    } catch (e) {
      print('Error in getImageUrl: $e');
      // Return the missing cover image in case of any exception
      return 'assets/images/books/missing_cover.jpeg';
    }
  }
}
