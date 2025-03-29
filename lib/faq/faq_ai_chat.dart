import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'groq_controller.dart'; // Import the GroqController

class FAQAIChatPage extends StatefulWidget {
  const FAQAIChatPage({super.key});

  @override
  State<FAQAIChatPage> createState() => _FAQAIChatPageState();
}

class _FAQAIChatPageState extends State<FAQAIChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late final GroqController _groqController;

  @override
  void initState() {
    super.initState();
    _groqController = GroqController(); // Initialize GroqController
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'message': _controller.text});
    });

    final userMessage = _controller.text;
    _controller.clear();

    // Simulate Groq AI response
    final aiResponse = await _getAIResponse(userMessage);

    setState(() {
      _messages.add({'sender': 'ai', 'message': aiResponse});
    });
  }

  Future<String> _getAIResponse(String message) async {
    return await _groqController.getAIResponse(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'FAQ',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the FAQ page
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.white : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['message']!,
                      style: GoogleFonts.poppins(
                        color: isUser ? Colors.black : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Silakan ajukan pertanyaan Anda!',
                      hintStyle: GoogleFonts.poppins(color: Colors.black45),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Kirim',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
