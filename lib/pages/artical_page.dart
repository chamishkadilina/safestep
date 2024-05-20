import 'package:flutter/material.dart';

class ArticalPage extends StatelessWidget {
  const ArticalPage({super.key});

  static String id = 'artical_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Show Daily Articals',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
