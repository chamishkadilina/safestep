import 'package:flutter/material.dart';

class IconBoxTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final IconData? icon;

  const IconBoxTile({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // icon
                  Icon(
                    icon,
                    size: 128,
                  ),
                  const SizedBox(height: 8),
                  // text
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
