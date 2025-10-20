import 'package:flutter/material.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionButton extends StatelessWidget {
  final String text;
  final String price;
  final void Function()? onTap;
  const DescriptionButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text of the button
            Text(text,
                style: GoogleFonts.inter(
                    color: thirdColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Text(price,
                style: GoogleFonts.inter(
                    color: thirdColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
