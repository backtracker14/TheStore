import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:htu_capstone_project0/pages/auth/order_history.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double totalCost = 0;
    for (CartItem item in order.items) {
      totalCost += item.price * item.quantity;
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ID: ${order.orderId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Total Cost: \$${totalCost.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Timestamp: ${DateFormat('MMM dd, yyyy HH:mm').format(order.timestamp)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Items:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  CartItem item = order.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                    trailing: Text('Quantity: ${item.quantity}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
