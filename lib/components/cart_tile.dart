import 'package:flutter/material.dart';
import 'package:furniture_shop/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/model/model.dart';

class CartTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  CartTile({super.key, required this.product, this.onTap});

  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        padding: const EdgeInsets.all(25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Product Image
            Image.asset(
              product.imageUrl,
              width: 80,
            ),
            const SizedBox(width: 24), // space between image and info

            // Right: Product info column
            Expanded(
              child: Column(
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
                  const SizedBox(height: 4),

                  // Product Type
                  Text(
                    product.type,
                    style: GoogleFonts.inter(fontSize: 16, color: thirdColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      IconButton(
                        onPressed: () {
                          productController.removeFromCart(product);
                          ;
                        },
                        icon: Image.asset(
                          "assets/images/trash.png",
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
