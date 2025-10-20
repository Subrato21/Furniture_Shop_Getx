import 'package:flutter/material.dart';
import 'package:furniture_shop/components/description_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/controller/product_description_controller.dart';
import 'package:furniture_shop/model/model.dart';
import 'package:furniture_shop/theme/colors.dart';

class ProductDescriptionPage extends StatelessWidget {
  final Product product;

  const ProductDescriptionPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final ProductDescriptionController controller =
        Get.put(ProductDescriptionController());

    // Reactive variable for Read More toggle
    final RxBool isExpanded = false.obs;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content behind AppBar
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 50, // desired width of your circular container
            height: 50, // desired height
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Image.asset(
                  "assets/images/back.png",
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              width: 50, // desired width of your circular container
              height: 50, // desired height
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle, // makes it circular
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/favourite.png",
                      color: Colors.black, width: 24, height: 24),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack to put image behind AppBar
            Stack(
              children: [
                // Product image
                Image.asset(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Product name, type, rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side — product info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.type,
                        style: GoogleFonts.inter(
                          color: thirdColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Right side — rating
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Product description with Read More
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.description,
                      style: GoogleFonts.inter(
                        color: thirdColor,
                        fontSize: 16,
                      ),
                      maxLines: isExpanded.value
                          ? null
                          : 2, // isExpanded False initially so it will make it 2 line  if True do nothing.
                      overflow: isExpanded.value
                          ? TextOverflow.visible
                          : TextOverflow
                              .ellipsis, // add ... dot after making 2 lines
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => isExpanded.value = !isExpanded
                          .value, // initially isExpanded is false but after tapping it makes it to True,
                      child: Text(
                        isExpanded.value ? "Read Less" : "Read More",
                        style: GoogleFonts.inter(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),

            // Color selector + Quantity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Colors
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Row(
                            children: List.generate(
                              controller.colorOptions.length,
                              (index) => GestureDetector(
                                onTap: () => controller.changeColor(index),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: controller.colorOptions[index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          controller.selectedColorIndex.value ==
                                                  index
                                              ? Colors.black
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),

                  // Quantity controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: controller.decrement,
                      ),
                      Obx(() => Text(
                            controller.quantity.value.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: controller.increment,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 150),

            // Add to cart button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DescriptionButton(
                text: 'Add to Cart ',
                price: ' | ' '\$${product.price.toInt()}',
                onTap: () {
                  controller.addToCart(product);
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
