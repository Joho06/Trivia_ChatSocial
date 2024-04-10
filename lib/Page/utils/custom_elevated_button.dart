import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.buttonWidth,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;
  get color => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white38, // Cambia el color del botón aquí
        ),
        child: Text(text,
          style: TextStyle(
            color: Colors.black, // Cambia el color del texto según lo deseado
          ),
        ),
      ),
    );
  }
}