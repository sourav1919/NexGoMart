import 'package:equatable/equatable.dart';
import '../../domain/models/cart_item.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;

  CartUpdated({required this.items});

  double get totalPrice =>
      items.fold(0, (total, item) => total + item.totalPrice);

  @override
  List<Object?> get props => [items, totalPrice];
}
