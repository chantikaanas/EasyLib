import 'package:flutter/material.dart';

class BookReturnScreen extends StatefulWidget {
  const BookReturnScreen({super.key});

  @override
  _BookReturnScreenState createState() => _BookReturnScreenState();
}

class _BookReturnScreenState extends State<BookReturnScreen> {
  int _currentPage = 0;

  void _nextPage() {
    setState(() {
      if (_currentPage < 2) {
        _currentPage++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pengembalian'),
        content: Text('Apakah kamu sudah yakin untuk mengembalikan buku ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextPage();
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengembalian'),
      ),
      body: Column(
        children: [
          if (_currentPage == 0) BookDetailPage(onNext: _nextPage),
          if (_currentPage == 1)
            ConfirmationPage(
              onConfirm: _showConfirmationDialog,
              onCancel: _previousPage,
            ),
          if (_currentPage == 2) SuccessPage(),
        ],
      ),
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final VoidCallback onNext;

  const BookDetailPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Bintang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Image.asset(
          'assets/images/books/book1.png',
          width: 80,
          height: 120,
        ),
        Text('Tere Liye', style: TextStyle(fontSize: 18)),
        Text('Rating: ★★★☆☆', style: TextStyle(fontSize: 16)),
        ElevatedButton(
          onPressed: onNext,
          child: Text('Kembalikan'),
        ),
      ],
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationPage({super.key, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Apakah kamu sudah yakin untuk mengembalikan buku ini?'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: onCancel, child: Text('Tidak')),
            TextButton(onPressed: onConfirm, child: Text('Ya')),
          ],
        ),
      ],
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.check_circle, color: Colors.blue, size: 100),
        Text('Pengembalian berhasil dilakukan!'),
        Text('Terima kasih sudah mengembalikan buku ini!!'),
      ],
    );
  }
}
