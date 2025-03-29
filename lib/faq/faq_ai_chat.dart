import 'package:flutter/material.dart';

class FAQAIChatPage extends StatelessWidget {
  const FAQAIChatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Apakah terdapat sanksi bila buku yang dipinjam mengalami kerusakan?',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Ya, peminjam bertanggung jawab atas kondisi buku yang dipinjam.\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Jika terjadi kerusakan, maka akan dikenakan sanksi sesuai dengan tingkat kerusakan, yang dapat berupa peringatan, denda, atau kewajiban mengganti buku yang rusak. Informasi lebih lanjut mengenai ketentuan ini dapat dilihat pada halaman "Kebijakan Peminjaman".',
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Silakan ajukan pertanyaan Anda!',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Kirim'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
