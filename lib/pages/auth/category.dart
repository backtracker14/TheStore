import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/pages/auth/product.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

class CategoryList extends StatelessWidget {
  final CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');
  final CategoryController categoryController = Get.put(CategoryController());

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (_) {
        if (categoryController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (categoryController.categories.isEmpty) {
          return const Text('No categories found.');
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              Category category = categoryController.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GridTile(
                  child: GestureDetector(
                    onTap: () {
                      categoryController.setSelectedCategory(category);
                      Get.to(() => ProductPage());
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            imageUrl: category.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.red[900],
                            colorBlendMode: BlendMode.overlay,
                          ),
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.white,
                            // backgroundColor: Colors.amber,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 3,
                            decoration: TextDecoration.combine([
                              TextDecoration.overline,
                              TextDecoration.underline
                            ]),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            scrollDirection: Axis.vertical,
          );
        }
      },
    );
  }
}

class CategoryController extends GetxController {
  final isLoading = true.obs;
  final categories = <Category>[].obs;
  final selectedCategory = Category(id: '', name: '', imageUrl: '').obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    categories.refresh();
    update();
  }

  void fetchCategories() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('name')
          .get();
      update();

      categories.value = querySnapshot.docs
          .map((doc) {
            return Category(
                id: doc.id,
                name: doc.data()['name'],
                imageUrl: doc.data()["imageUrl"]);
          })
          .toList()
          .obs;
      categories.refresh();
      update();

      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
      isLoading.value = false;
      update();
    }
  }

  void setSelectedCategory(Category category) {
    selectedCategory.value = category;
    update();
  }
}
