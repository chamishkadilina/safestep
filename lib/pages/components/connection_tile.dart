import 'package:flutter/material.dart';

class ConnectionTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  // final void Function()? onTap;

  const ConnectionTile({
    required this.text,
    // required this.onTap,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade300,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // connection status
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Connection\nStatus',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // wifi icon
                Icon(
                  icon,
                  size: 72,
                ),
                const SizedBox(height: 8),
                // connected indicator
                GestureDetector(
                  // onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
