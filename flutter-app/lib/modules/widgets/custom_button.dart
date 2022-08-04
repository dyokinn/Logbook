import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Size size;
  final IconData? icon;

  const CustomButton({ 
    Key? key,
    required this.onPressed, 
    this.text = "",
    required this.size,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return icon == null 

    ? ElevatedButton(
      onPressed: onPressed, 
      child: Text(text!),
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        primary: MainColors.green
      ),
      )
    : ElevatedButton(
      onPressed: onPressed, 
      child: Center(child: Icon(icon, size: 30)),
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        primary: MainColors.green
      ),
    );
  }
}