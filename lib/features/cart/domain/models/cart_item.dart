class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({required this.id, required this.name, required this.price, required this.quantity});

  CartItem copyWith({String? id, String? name, double? price, int? quantity}) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => price * quantity;
}
