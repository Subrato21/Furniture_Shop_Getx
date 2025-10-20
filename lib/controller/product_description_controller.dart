import 'package:flutter/material.dart';
import 'package:furniture_shop/model/model.dart';
import 'package:furniture_shop/controller/product_controller.dart';
import 'package:furniture_shop/theme/colors.dart';
import 'package:get/get.dart';

class ProductDescriptionController extends GetxController {
  // Reactive variables
  var quantity = 0.obs;
  var selectedColorIndex = 0.obs;

  // Example color list
  final List<Color> colorOptions = [
    thirdColor,
    primaryColor,
    Colors.redAccent,
  ];

  // Increase quantity
  void increment() {
    quantity.value++;
  }

  // Decrease quantity
  void decrement() {
    if (quantity.value > 0) quantity.value--;
  }

  // Change color
  void changeColor(int index) {
    selectedColorIndex.value = index;
  }

  void addToCart(Product product) {
    // only add to cart if there is something in the cart
    if (quantity.value > 0) {
      //access global Product Controller
      final productController = Get.find<ProductController>();

      //add to cart
      productController.addToCart(product, quantity.value);

      //let the user know it was successful
      Get.snackbar(
        'Added to Cart',
        '${product.name} (${quantity.value}) added!',
        backgroundColor: fifthColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
      );
    }
  }
}
