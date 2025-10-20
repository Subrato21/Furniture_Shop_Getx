import 'package:flutter/material.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/model/model.dart';

class BestSellerTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const BestSellerTile({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    // Product Image
                    Image.asset(
                      product.imageUrl,
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          //product type

                          Text(
                            product.type,
                            style: GoogleFonts.inter(
                                fontSize: 18, color: thirdColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Price
                          Text(
                            '\$${product.price.toStringAsFixed(0)}',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
