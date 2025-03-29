import 'package:flutter/material.dart';

class FAQQuestionInputPage extends StatelessWidget {
  const FAQQuestionInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

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
            const Text(
              'Tulis pertanyaan Anda disini!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black54),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukkan pertanyaan Anda...'
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Kirim pertanyaan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
