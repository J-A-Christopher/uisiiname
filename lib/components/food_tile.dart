import 'package:flutter/material.dart';

class FoodTitle extends StatelessWidget {
  final String foodTitle;
  const FoodTitle({required this.foodTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      foodTitle,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold,),
      maxLines: 2,
    );
  }
}
