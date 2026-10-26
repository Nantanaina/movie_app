import 'package:flutter/material.dart';

// 1
typedef OnMoreClicked = void Function();

class TitleRow extends StatelessWidget {
  final String text;
  final OnMoreClicked onMoreClicked;
  const TitleRow({super.key, required this.text, required this.onMoreClicked});
  @override
  Widget build(BuildContext context) {
    // 2
    return Row(
      // 3
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 8.0),
          // 4
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        // 5
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16.0, 8.0, 0.0),
          // 6
          child: TextButton(
            onPressed: onMoreClicked,
            child: const Text(
              'More',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
