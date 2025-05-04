import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/auth_bridge.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String _gender = 'male';
  bool _isLoading = false;
  String _errorMessage = '';
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final result = await AuthBridge.register(
        name: _nameController.text.trim(),
        gender: _gender,
        address: _addressController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        dateOfBirth: _dobController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );

      if (result['success']) {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
      } else {
        setState(() {
          _errorMessage = result['message'];
          // Handle validation errors
          if (result.containsKey('errors') && result['errors'] is Map) {
            final errors = result['errors'] as Map;
            if (errors.isNotEmpty) {
              final firstError = errors.entries.first;
              if (firstError.value is List &&
                  (firstError.value as List).isNotEmpty) {
                _errorMessage = (firstError.value as List)[0];
              }
            }
          }
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pendaftaran',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                _buildTextField(
                  controller: _nameController,
                  label: 'Nama Lengkap',
                  validator: (value) =>
                      value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),

                // Gender Selection
                Text(
                  'Jenis Kelamin',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Laki-laki', style: GoogleFonts.poppins()),
                        value: 'male',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _gender = value;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Perempuan', style: GoogleFonts.poppins()),
                        value: 'female',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _gender = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Date of Birth Field
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: _buildTextField(
                      controller: _dobController,
                      label: 'Tanggal Lahir',
                      suffixIcon: Icons.calendar_today,
                      validator: (value) =>
                          value!.isEmpty ? 'Tanggal lahir harus diisi' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Phone Field
                _buildTextField(
                  controller: _phoneController,
                  label: 'Nomor Telepon',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) return 'Nomor telepon harus diisi';
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nomor telepon hanya boleh angka';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Address Field
                _buildTextField(
                  controller: _addressController,
                  label: 'Alamat',
                  maxLines: 3,
                  validator: (value) =>
                      value!.isEmpty ? 'Alamat harus diisi' : null,
                ),
                const SizedBox(height: 16),

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return 'Email harus diisi';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  label: 'Kata Sandi',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Kata sandi harus diisi';
                    if (value.length < 3)
                      return 'Kata sandi minimal 3 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Konfirmasi Kata Sandi',
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),

                // Error Message
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage,
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // Register Button
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
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Link
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Sudah memiliki akun? ',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: 'Masuk Di sini',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
