import 'package:flutter/material.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // extends to the top as we used an image in a column
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // icon
          Expanded(
            child: Image.asset('assets/images/chair1.jpg'),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Expanded(
              child: Column(
                children: [
                  // title
                  Text(
                    'Enjoy Your Online Shopping',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // subtitile
                  Text(
                    'Browse through all categories and shop the best furniture for your dream house',
                    style: TextStyle(color: secondaryColor, fontSize: 18),
                  ),

                  const SizedBox(height: 25),
                  //get started button
                  MyButton(
                    text: 'Get Started',
                    onTap: () {
                      // go to the menu page
                      Navigator.pushNamed(context, '/homepage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
