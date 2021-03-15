import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  final List<String> errors;

  const FormError({Key? key, required this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        errors.length,
        (index) => formErrorText(
          errors[index],
        ),
      ),
    );
  }
}

Padding formErrorText(String error) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red),
        SizedBox(width: 5),
        Text(error, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}
