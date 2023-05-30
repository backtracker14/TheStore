import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:htu_capstone_project0/pages/auth/order_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Order {
  final String orderId;
  final List<CartItem> items;
  final DateTime timestamp;

  Order({
    required this.orderId,
    required this.items,
    required this.timestamp,
  });
}

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.order),
      subtitle: Text(
          '${AppLocalizations.of(context)!.totalItems} ${order.items.length}'),
      trailing: Text(
          '${AppLocalizations.of(context)!.date}: ${DateFormat.yMMMMd().format(order.timestamp)}'),
      onTap: () {
        Get.to(OrderDetailsPage(order: order));
      },
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.purchaseHistory),
      ),
      body: SafeArea(
        child: GetBuilder<OrderController>(
          builder: (orderController) {
            if (orderController.orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: orderController.orders.length,
                itemBuilder: (context, index) {
                  Order order = orderController.orders[index];
                  return OrderItem(order: order);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderController extends GetxController {
  final orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    update();
  }

  void fetchOrders() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('order_history')
          .orderBy('timestamp', descending: true)
          .get();
      update();

      orders.value = querySnapshot.docs.map((doc) {
        List<dynamic> itemsData = doc.data()['items'];
        List<CartItem> items = itemsData.map((itemData) {
          return CartItem(
            name: itemData['name'],
            price: itemData['price'].toDouble(),
            quantity: itemData['quantity'],
            id: '',
            imageUrl: '',
          );
        }).toList();
        update();

        return Order(
          orderId: doc.id,
          items: items,
          timestamp: doc.data()['timestamp'].toDate(),
        );
      }).toList();
      update();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching orders: $e');
        update();
      }
    }
  }
}
