import 'package:flutter/material.dart';
import 'package:furniture_shop/controller/product_controller.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/model/model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductTile({super.key, required this.product, this.onTap});

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
            Column(
              children: [
                // Product Image
                Image.asset(
                  product.imageUrl,
                  height: 140,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width:
                      160, // here added sized box and given fixed width so that we can use spacebetween without it it will not work
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Optional: "New" badge
                          product.isNew
                              ? Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'NEW',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),

                      // Rating
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.yellowAccent.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // Wrap content
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.brown.shade500,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

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
            const SizedBox(height: 8),

            //product type

            Text(
              product.type,
              style: GoogleFonts.inter(fontSize: 18, color: thirdColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // price and add icon
            // here added sized box and given fixed width so that we can use spacebetween without it it will not work
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle, // makes it circular
                    ),
                    child: IconButton(
                      onPressed: () {
                        //Get the global ProductController instance so that we can accewss addToCart function
                        final productController = Get.find<ProductController>();

                        // add 1 quantity of this product
                        productController.addToCart(product, 1);

                        //show a snackbar confirmation
                        Get.snackbar(
                          'Added to Cart',
                          '${product.name} added!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: fifthColor,
                          duration: Duration(seconds: 1),
                        );

                        //  added alternative alert style
                        // Get.dialog(
                        //   AlertDialog(
                        //     title: const Text('Added to Cart'),
                        //     content: Text('${product.name} has been added!'),
                        //     actions: [
                        //       TextButton(
                        //         onPressed: () => Get.back(), // Close the dialog
                        //         child: const Text('OK'),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
