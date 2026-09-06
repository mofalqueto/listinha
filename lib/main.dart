import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const ListinhaApp());
}

class ListinhaApp extends StatelessWidget {
  const ListinhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listinha',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFCC3E)),
      ),
      home: const HomePage(),
    );
  }
}
