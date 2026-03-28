import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
   const SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14, fontFamily: "dancing",
      ),
    );
  }
}