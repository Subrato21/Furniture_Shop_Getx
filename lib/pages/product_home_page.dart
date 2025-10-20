import 'package:flutter/material.dart';
import 'package:furniture_shop/components/best_seller_tile.dart';
import 'package:furniture_shop/components/product_tile.dart';
import 'package:furniture_shop/pages/product_description_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:furniture_shop/controller/product_controller.dart';

class ProductHomePage extends StatelessWidget {
  ProductHomePage({super.key});

  // navigate to product detail page
  void navigateToProductDetails(BuildContext context, int index) {
    final product = controller.filteredProducts[index];
    Get.to(() => ProductDescriptionPage(product: product));
  }

  // initialize GetX controller
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250, // control width so text wraps
                      child: Text(
                        "Discover the Best Furniture",
                        //maxLines: 2, // allow 2 lines max
                        // overflow: TextOverflow
                        //     .ellipsis, // optional: adds "..." if too long
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 28, // size of circle
                      backgroundImage: AssetImage("assets/images/boy.png"),
                    ),
                  ],
                ),

                const SizedBox(height: 25), // spacing between row & search bar

                // search bar
                TextField(
                  decoration: InputDecoration(
                    filled: true, // enable background color
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Search for furniture,',
                    hintStyle: TextStyle(color: secondaryColor),
                    prefixIcon:
                        Icon(Icons.search), // search icon inside the field
                    suffixIcon: Icon(
                      Icons.filter_list,
                    ), // filter icon at the end (leading side is prefixIcon)
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Categories",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // category list
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];

                      // Wrap each item with Obx so it reacts individually
                      return Obx(() {
                        final isSelected =
                            controller.selectedCategory.value == category.name;

                        return GestureDetector(
                          onTap: () => controller.changeCategory(category.name),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? primaryColor : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // product grid
          Expanded(
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return ProductTile(
                    product: product,
                    onTap: () => navigateToProductDetails(context, index),
                  ); //used product tile decorations
                },
              ),
            ),
          ),

          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              "Best Seller",
              style: GoogleFonts.inter(
                fontSize: 20,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // product grid
          SizedBox(
            height: 80,
            child: Obx(() {
              // get best-seller cupboards
              final cupboards = controller.bestSellerCupboards;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cupboards.length,
                itemBuilder: (context, index) {
                  final product = cupboards[index];
                  return BestSellerTile(
                    product: product,

                    onTap: () => (Get.to(() => ProductDescriptionPage(
                        product:
                            product))), // this is the alternative way to pass the exact product to description page without using void function
                  ); // used product tile decorations
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
