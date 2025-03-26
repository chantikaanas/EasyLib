import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peminjaman Buku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookDetailsPage(),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peminjaman Buku'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Center(
              child: Image.asset('assets/images/books/book1.png', width: 80, height: 120,), // Replace with your image asset path
            ),
            SizedBox(height: 20),
            // Book Title and Author
            Text(
              'Bintang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tere Liye',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            // Category and Rating
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.blue,
                  child: Text(
                    'Romance',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: List.generate(4, (index) {
                    return Icon(Icons.star, color: Colors.yellow);
                  }) +
                      List.generate(1, (index) {
                        return Icon(Icons.star_border, color: Colors.yellow);
                      }),
                ),
              ],
            ),
            SizedBox(height: 20),
            // About Books Section
            Text(
              'About Books',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Nomor Panggil: 01231', style: TextStyle(fontSize: 16)),
            Text('Ketersediaan: 13/50', style: TextStyle(fontSize: 16)),
            Text('Tipe Media: Fisik', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              'Abstract',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ornare hendrerit nunc, a ornare neque condimentum vitae. Curabitur sagittis justo elit, nec fermentum ipsum venenatis tempor. Curabitur tincidunt mauris ac imperdiet dapibus. Vivamus augue purus, bibendum.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Pinjam (Borrow) Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Show the confirmation dialog
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  foregroundColor: Colors.white,
                ),
                child: Text('Pinjam'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Peminjaman'),
          content: Text('Apakah kamu yakin akan meminjam buku ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // If "No" is pressed, close the dialog and stay on the page
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                // If "Yes" is pressed, show success message and close the dialog
                Navigator.of(context).pop(); // Close the confirmation dialog
                _showSuccessDialog(context); // Show the success dialog
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the success dialog after borrowing
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Peminjaman Berhasil'),
        content: Text('Buku berhasil dipinjam!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
