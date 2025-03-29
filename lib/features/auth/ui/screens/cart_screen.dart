import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Items", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildCartItem(context, "Product $index", "₹${(index + 1) * 50}");
                },
              ),
            ),
            Divider(thickness: 1, height: 20),
            _buildTotalAmount(),
            SizedBox(height: 80), // Space for floating button
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.green.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text("Proceed to Checkout", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCartItem(BuildContext context, String name, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/placeholder.jpg',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 5),
                  Text(price, style: TextStyle(color: Colors.green, fontSize: 14)),
                ],
              ),
            ),
            _buildQuantityControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {},
        ),
        Text("1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(Icons.add_circle, color: Colors.green),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTotalAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Amount:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("₹150", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    );
  }
}
