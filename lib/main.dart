import 'package:flutter/material.dart';
import 'package:os_virtual_lab/execute_page.dart';
import 'package:os_virtual_lab/utils/providers.dart';
import 'package:provider/provider.dart';
import 'round_robin_page.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputData()),
        ChangeNotifierProvider(create: (_) => Process())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) => const RoundRobinPage(),
        "/execute_page": (context) => const ExecutePage(),
      },
    );
  }
}
