import 'package:flutter/material.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  static const String route = '/LanguagesScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  Color(0xFF292241),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Wybierz język'),
            ],
          ),
        ),
      ),
    );
  }
}
