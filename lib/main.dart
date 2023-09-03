import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrumboard/Provider/provider_home_screen.dart';
import 'package:scrumboard/View/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Flutter demo",
      home: HomeScreen(),
    );
  }
}
