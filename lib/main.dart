import 'package:easy_lib/auth/login.dart';
import 'package:easy_lib/auth/register.dart';
import 'package:easy_lib/editProfile.dart';
import 'package:easy_lib/homepage.dart';
import 'package:easy_lib/kartuanggota.dart';
import 'package:easy_lib/mainPage.dart';
import 'package:easy_lib/peminjaman.dart';
import 'package:easy_lib/pengembalian.dart';
import 'package:easy_lib/profilePage.dart';
import 'package:easy_lib/searchpage.dart';
import 'package:easy_lib/booklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//  Tambahkan import untuk halaman FAQ
import 'package:easy_lib/faq/faq_page.dart';
import 'package:easy_lib/faq/faq_question_input.dart';
import 'package:easy_lib/faq/faq_ai_chat.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");
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
      home: LoginPage(), // Halaman awal utama
      initialRoute: '/',
      routes: {
        '/main': (context) => MainPage(),
        '/home': (context) => HomePage(),
        '/search': (context) => SearchScreen(),
        '/kartuanggota': (context) => KartuanggotaPage(),
        '/profile': (context) => ProfilePage(),
        '/booklist': (context) => BookListPage(),
        '/bookdetails': (context) => BookDetailsPage(),
        '/pengembalian': (context) => BookReturnScreen(),
        '/editprofile': (context) => Editprofile(),

        // AUTH
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),

        //  Tambahan routing FAQ
        '/faq': (context) => const FAQPage(),
        '/ask': (context) => const FAQQuestionInputPage(),
        '/chat': (context) => const FAQAIChatPage(),
      },
    );
  }
}
