import 'package:flutter/material.dart';

class BannerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const BannerTile({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // text
              Text(
                text,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              // icon
              Icon(
                icon,
                size: 128,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
