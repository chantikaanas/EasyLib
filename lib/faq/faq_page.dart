import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqList = [
      {
        'question': 'Cara mendaftar anggota?',
        'answer':
        'Anda dapat mendaftar melalui aplikasi dengan mengisi formulir dan mengaktifkan kartu anggota.'
      },
      {
        'question': 'Apakah peminjaman berbayar?',
        'answer':
        'Tidak. Peminjaman buku melalui aplikasi ini sepenuhnya gratis tanpa biaya apa pun. Anda hanya perlu memiliki kartu anggota yang aktif untuk mulai meminjam.'
      },
      {
        'question': 'Bagaimana meminjam buku?',
        'answer':
        'Cukup scan QR kode buku dengan aplikasi dan konfirmasi peminjaman.'
      },
      {
        'question': 'Cara bisa mengganti password?',
        'answer':
        'Masuk ke menu Profil > Keamanan > Ganti Password.'
      },
      {
        'question': 'Bagaimana cara ganti profil?',
        'answer':
        'Buka menu Profil dan pilih “Edit Profil” untuk mengganti data Anda.'
      },
      {
        'question': 'Apa sanksi jika terlambat dalam pengembalian?',
        'answer':
        'Anda akan mendapat peringatan dan bisa diblokir sementara jika terlambat berulang.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('FAQ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...faqList.map((faq) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  title: Text(faq['question']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(faq['answer']!, style: const TextStyle(color: Colors.black54, height: 1.5)),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ask');
                },
                child: const Text(
                  'Apakah Anda masih memiliki pertanyaan?',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}