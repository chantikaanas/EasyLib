import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KartuanggotaPage extends StatelessWidget {
  const KartuanggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.9;
    double cardHeight =
        cardWidth * 0.6; // Menyesuaikan rasio kartu agar tetap proporsional

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1E78D1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF78B7EB),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        Image.asset('assets/images/profile/Profile.png').image,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ID: 000123",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "KARTU ANGGOTA PERPUSTAKAAN",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    _buildInfoRow(
                        "Nama Lengkap", "Asep Kurniawan", Color(0xFF3E78B2)),
                    _buildInfoRow(
                        "Tanggal Bergabung", "25/12/2025", Color(0xFF3E78B2)),
                    _buildInfoRow("Status", "AKTIF", Color(0xFF3AA86D)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(height: 2),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}