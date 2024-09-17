import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap, required this.text});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            fontSize: 25,
          ),
        )),
      ),
    );
  }
}
