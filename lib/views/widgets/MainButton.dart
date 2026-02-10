import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;

  const MainButton({super.key, this.onPressed, this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Colors.redAccent,
          minimumSize: const Size(double.infinity, 55),
          elevation: 1,
        ),
        onPressed: onPressed,
        child:
            child ??
            Text(
              text ?? '',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
    );
  }
}
