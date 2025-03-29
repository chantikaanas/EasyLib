import 'package:easy_lib/homepage.dart';
import 'package:easy_lib/kartuanggota.dart';
import 'package:easy_lib/mainPage.dart';
import 'package:easy_lib/profilePage.dart';
import 'package:easy_lib/searchpage.dart';
import 'package:flutter/material.dart';

//  Tambahkan import untuk halaman FAQ
import 'package:easy_lib/faq/faq_page.dart';
import 'package:easy_lib/faq/faq_question_input.dart';
import 'package:easy_lib/faq/faq_ai_chat.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyLib',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: mainPage(), // Halaman awal utama
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/search': (context) => SearchScreen(),
        '/kartuanggota': (context) => KartuanggotaPage(),
        '/profile': (context) => profilePage(),

        //  Tambahan routing FAQ
        '/faq': (context) => const FAQPage(),
        '/ask': (context) => const FAQQuestionInputPage(),
        '/chat': (context) => const FAQAIChatPage(),
      },
    );
  }
}
