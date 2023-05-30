// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:htu_capstone_project0/pages/auth/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;

  void updateCart() {
    cartItems.refresh();
    update();
  }

  void checkout() async {
    // Save the cart items as order history in Firestore
    await FirebaseFirestore.instance.collection('order_history').add({
      'timestamp': DateTime.now(),
      'items': cartItems.map((item) => item.toMap()).toList(),
    });

    // Clear the cart
    clearCart();
    updateCart();
    update();
  }

  void clearCart() {
    cartItems.clear();
    updateCart();
    update();
  }

  void addItem(CartItem item) {
    // Check if the item already exists in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      // Item already exists, increment the quantity
      cartItems[index].quantity++;
      updateCart();
      update();
    } else {
      // Item doesn't exist, add it to the cart
      cartItems.add(item);
      update();
    }
  }

//just in case
  void incrementItemQuantity(CartItem item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      cartItems[index].quantity++;
      updateCart();
      update();
    }
  }

  void decrementItemQuantity(CartItem item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        // Remove item from the cart if quantity reaches 1
        cartItems.removeAt(index);
      }
    }
    updateCart();
    update();
  }

//remove item
  void removeItem(CartItem item) {
    cartItems.removeWhere((cartItem) => cartItem.id == item.id);
    updateCart();
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
      updateCart();
      update();
    }
    return total;
  }
}

class LanguageController extends GetxController {
  final RxString selectedLanguage = ''.obs;

  void setLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    Locale? locale; // Declare as nullable
    if (languageCode == 'en') {
      locale = const Locale('en', 'US');
    } else if (languageCode == 'ar') {
      locale = const Locale('ar', 'SA');
    }
    Get.updateLocale(locale!); // Use non-nullable value
  }

  String getSelectedLanguageName() {
    // ignore: unused_local_variable
    final appLocalization = AppLocalizations.of(Get.context!);
    if (selectedLanguage.value == 'en') {
      return 'English';
    } else if (selectedLanguage.value == 'ar') {
      return 'Arabic';
    }
    return '';
  }
}
