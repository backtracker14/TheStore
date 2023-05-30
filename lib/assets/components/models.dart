class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}

class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
