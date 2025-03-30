import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, String> orderData;

  const OrderDetailsScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: ${orderData['orderId']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Total Price: ${orderData['price']}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Status: ${orderData['status']}", style: TextStyle(fontSize: 16, color: orderData['status'] == "Delivered" ? Colors.green : Colors.orange)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text("Back to Orders"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}