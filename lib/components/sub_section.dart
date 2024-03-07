import 'package:flutter/material.dart';

class SubSection extends StatelessWidget {
  final String heading;
  const SubSection({required this.heading, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, ),
    );
  }
}
