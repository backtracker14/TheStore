import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:htu_capstone_project0/assets/controllers/some_controllers.dart';
import 'package:htu_capstone_project0/pages/auth/cart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:htu_capstone_project0/pages/empty_page.dart';

import 'category.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.category});

  CartItem toCartItem() {
    return CartItem(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: 1, // Default quantity is 1 when adding to cart
    );
  }
}

class ProductPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
          )
        ],
        title: Container(
          alignment: Alignment.center,
          height: Get.height / 20,
          child: Center(
            child: TextField(
              style: const TextStyle(
                  // backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
              controller: searchController,
              onChanged: (value) {
                // Perform search based on the entered value
                productController.searchProducts(value);
              },
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                hintText: AppLocalizations.of(context)!.search,
                contentPadding: const EdgeInsets.all(
                  10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  // borderSide: ,
                ),
                // icon: Icon(
                //   Icons.search,
                // ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<CategoryController>(
          builder: (categoryController) {
            return GetBuilder<ProductController>(
              builder: (productController) {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (productController.products.isEmpty) {
                  return const EmptyCat();
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      Product product = productController.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridTile(
                          header: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              cartController.addItem(product.toCartItem());
                              Get.snackbar(
                                  AppLocalizations.of(context)!.addedToCart, '',
                                  // animationDuration:
                                  //     // const Duration(milliseconds: 30),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  duration: const Duration(seconds: 2));
                            },
                            icon: const Icon(Icons.add_circle,
                                color: Colors.white),
                            color: Theme.of(context).colorScheme.secondary,
                            iconSize: 40,
                          ),
                          footer: GridTileBar(
                            // backgroundColor:
                            //     Theme.of(context).colorScheme.primary,
                            title: Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            subtitle: Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            imageUrl: product.imageUrl,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductController extends GetxController {
  final isLoading = true.obs;
  final products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    products.refresh();
    update();
  }

  // void fetchProducts() async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('products')
  // .where('category',
  //     isEqualTo:
  //         Get.find<CategoryController>().selectedCategory.value.id)
  //         .orderBy('name')
  //         .get();
  //     update();

  //     products.value = querySnapshot.docs
  //         .map((doc) {
  //           return Product(
  //               id: doc.id,
  //               category: doc.data()['category'],
  //               name: doc.data()['name'],
  //               price: doc.data()['price'].toDouble(),
  //               imageUrl: doc.data()['imageUrl']);
  //         })
  //         .toList()
  //         .obs;
  //     products.refresh();
  //     update();

  //     isLoading.value = false;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error fetching products: $e');
  //       update();
  //     }
  //     isLoading.value = false;
  //     update();
  //   }
  // }
  void fetchProducts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category',
              isEqualTo:
                  Get.find<CategoryController>().selectedCategory.value.id)
          .orderBy('name')
          .get();
      update();

      products.value = querySnapshot.docs
          .map((doc) {
            return Product(
                id: doc.id,
                category: doc.data()['category'],
                name: doc.data()['name'],
                price: doc.data()['price'].toDouble(),
                imageUrl: doc.data()['imageUrl']);
          })
          .toList()
          .obs;
      products.refresh();
      update();

      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
        update();
      }
      isLoading.value = false;
      update();
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      // Reset to show all products when the search query is empty
      fetchProducts();
      update();
    } else {
      // Filter products based on the search query
      products.value = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList()
          .obs;
      update();
    }
  }
}
