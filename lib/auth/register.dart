import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Gender { Pria, Wanita }

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Registrasi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Form Fields
              buildTextField("Email"),
              buildTextField("Kata Sandi"),
              buildTextField("Nama"),
              DatePicker(),
              buildTextField("Institusi"),
              GenderPicker(),
              buildTextField("Nomor Telepon"),
              buildTextField("Alamat", maxLines: 3),
              SizedBox(height: 20),

              // Tombol Daftar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Daftar',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Text login
              Text.rich(
                TextSpan(
                  text: 'Sudah memiliki akun? ',
                  style: GoogleFonts.poppins(color: Colors.black87),
                  children: [
                    TextSpan(
                        text: 'Login Di sini',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(String hint, {int maxLines = 1}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        hintText: hint,
      ),
    ),
  );
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: _selectDate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Tanggal Lahir',
              style: GoogleFonts.poppins(
                color: selectedDate != null ? Colors.black : Colors.grey,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 8)),
            Icon(
              Icons.calendar_today,
              color: selectedDate != null ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class GenderPicker extends StatefulWidget {
  const GenderPicker({super.key});

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  Gender? _gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenis Kelamin',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: RadioListTile<Gender>(
                      title: Text(
                        'Pria',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                      ),
                      value: Gender.Pria,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      })),
              Expanded(
                  child: RadioListTile<Gender>(
                      title: Text(
                        'Wanita',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                      ),
                      value: Gender.Wanita,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      }))
            ],
          )
        ],
      ),
    );
  }
}
