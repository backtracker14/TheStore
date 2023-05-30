import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:htu_capstone_project0/assets/controllers/some_controllers.dart';
// ignore: unused_import
import 'package:htu_capstone_project0/pages/auth/product.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cart),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<CartController>(
          builder: (cartController) {
            if (cartController.cartItems.isEmpty) {
              return const Center(
                  child: Text(
                'Cart is empty.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        CartItem cartItem = cartController.cartItems[index];
                        return ListTile(
                          tileColor: Colors.white,
                          leading: CachedNetworkImage(
                            imageUrl: cartItem.imageUrl,
                            // height: Get.height / 15,
                            width: Get.width / 5,
                            fit: BoxFit.fill,
                          ),
                          title: Text(cartItem.name),
                          subtitle:
                              Text('\$${cartItem.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartController
                                      .decrementItemQuantity(cartItem);
                                  Get.snackbar(
                                      AppLocalizations.of(context)!
                                          .quantityChanged,
                                      '${AppLocalizations.of(context)!.quantity} ${cartItem.name} ${AppLocalizations.of(context)!.changedTo} ${cartItem.quantity}.',
                                      duration: const Duration(seconds: 2));
                                },
                                icon: const Icon(Icons.remove_circle),
                                color: Colors.red,
                              ),
                              Text(cartItem.quantity.toString()),
                              IconButton(
                                onPressed: () {
                                  cartController
                                      .incrementItemQuantity(cartItem);
                                  Get.snackbar(
                                      AppLocalizations.of(context)!
                                          .quantityChanged,
                                      '${AppLocalizations.of(context)!.quantity} ${cartItem.name} ${AppLocalizations.of(context)!.changedTo} ${cartItem.quantity}.',
                                      duration: const Duration(seconds: 2));
                                },
                                icon: const Icon(Icons.add_circle),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.total}: \$${cartController.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.secondary),
                              ),
                              onPressed: () {
                                cartController.checkout();
                                Get.snackbar('Payment System Unimplemented',
                                    "Items have been added to your order history",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.checkOut,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
