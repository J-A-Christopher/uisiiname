import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {
  final String details;
  const MealDetails({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      details,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      maxLines: 2,
    );
  }
}
