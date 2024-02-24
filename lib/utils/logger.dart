import 'package:flutter/material.dart';

class ErrorLogger extends StatelessWidget {
  final String error;
  const ErrorLogger({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}
