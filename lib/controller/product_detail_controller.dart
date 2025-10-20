import 'package:furniture_shop/theme/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductDetailController extends GetxController {
  // Reactive variables
  var quantity = 1.obs;
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
    if (quantity.value > 1) quantity.value--;
  }

  // Change color
  void changeColor(int index) {
    selectedColorIndex.value = index;
  }
}
