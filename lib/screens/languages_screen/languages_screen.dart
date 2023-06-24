import 'package:flutter/material.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  static const String route = '/LanguagesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292241),
      body: Column(
        children: [Text('Wybierz język')],
      ),
    );
  }
}
