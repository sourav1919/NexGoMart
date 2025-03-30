import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgomart/features/cart/domain/models/cart_item.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Items", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartUpdated && state.items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return _buildCartItem(context, item);
                      },
                    );
                  }
                  return const Center(child: Text("Your cart is empty!"));
                },
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartUpdated && state.items.isNotEmpty) {
                  return Column(
                    children: [
                      const Divider(thickness: 1, height: 20), // Show only if cart has items
                      _buildTotalAmount(state.totalPrice),
                    ],
                  );
                }
                return const SizedBox.shrink(); // Hide divider if cart is empty
              },
            ),
            const SizedBox(height: 80), // Space for floating button
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated && state.items.isNotEmpty) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FloatingActionButton.extended(
                onPressed: () {
                  context.read<CartBloc>().add(ClearCart());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully!")),
                  );
                },
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Proceed to Checkout (₹${state.totalPrice})",
                      style: const TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("₹${item.price} x ${item.quantity} = ₹${item.totalPrice}",
                      style: const TextStyle(color: Colors.green, fontSize: 14)),
                ],
              ),
            ),
            _buildQuantityControl(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControl(BuildContext context, CartItem item) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CartUpdated) {
          final updatedItem = state.items.firstWhere((i) => i.id == item.id);
          return Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => context.read<CartBloc>().add(DecreaseQuantity(item.id)),
              ),
              Text(updatedItem.quantity.toString(), 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.green),
                onPressed: () => context.read<CartBloc>().add(IncreaseQuantity(item.id)),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTotalAmount(double totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total Amount:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("₹$totalPrice",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    );
  }
}
