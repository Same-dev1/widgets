import 'package:flutter/material.dart';
import 'package:widgets/widgets/hobbies_selecter.dart';
import 'package:widgets/widgets/navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets',
      home: Scaffold(
        body: const HobbiesSelectorCard()
      ),
    );
  }
}
