import 'package:flutter/material.dart';

class ArticalPage extends StatelessWidget {
  const ArticalPage({super.key});

  static String id = 'artical_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 64),
              Center(
                child: Text(
                  'Show Daily Articals',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
