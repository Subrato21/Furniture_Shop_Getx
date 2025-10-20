import 'package:flutter/material.dart';
import 'package:furniture_shop/components/button.dart';
import 'package:furniture_shop/components/cart_tile.dart';
import 'package:furniture_shop/model/model.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:get/get.dart';
import 'package:furniture_shop/controller/product_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final ProductController controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.inter(
              fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    // Clear all products from the cart
                    controller.clearCart();
                  },
                  icon: Image.asset(
                    "assets/images/trash.png",
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            // customers cart
            Expanded(
              child: Obx(
                () {
                  return controller.cart.isEmpty
                      ? Center(
                          child: Text(
                            "Your cart is empty!",
                            style: GoogleFonts.inter(
                                color: primaryColor, fontSize: 25),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.cart.length,
                          itemBuilder: (context, index) {
                            // get product from cart
                            final Product product = controller.cart[index];

                            //return to list tile
                            return CartTile(
                              product: product,
                              onTap: () {
                                //remove product from cart
                                controller.removeFromCart(product);
                              },
                            );
                          },
                        );
                },
              ),
            ),

            // Checkout button
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: MyButton(
                text: "Proceed to Checkout",
                onTap: () {},
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
