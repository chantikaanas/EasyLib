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

  String getImageUrl() {
    // Only use coverUrl if it's a complete URL
    if (coverUrl != null && coverUrl!.isNotEmpty && coverUrl!.startsWith('http')) {
      return coverUrl!;
    }
    
    // Only use cover if it looks like a valid path and doesn't contain local asset paths
    if (cover != null && cover!.isNotEmpty && !cover!.contains('assets/images')) {
      // If cover path looks like a server path (not a local asset path)
      if (!cover!.startsWith('http')) {
        // Construct a server URL
        return 'http://localhost:8000/storage/covers/$cover';
      }
      return cover!;
    }
    
    // Default placeholder within the app
    return 'assets/images/books/placeholder.png';
  }
}
