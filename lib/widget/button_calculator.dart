import 'package:flutter/material.dart';

class ButtonCalculator extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;
  final String keyValue;
  const ButtonCalculator(
      {super.key,
      required this.color,
      required this.text,
      required this.onTap,
      required this.keyValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(keyValue),
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}
