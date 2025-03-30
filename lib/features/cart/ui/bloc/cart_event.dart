import 'package:equatable/equatable.dart';
import '../../domain/models/cart_item.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  RemoveFromCart(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class IncreaseQuantity extends CartEvent {
  final String itemId;

  IncreaseQuantity(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class DecreaseQuantity extends CartEvent {
  final String itemId;

  DecreaseQuantity(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class ClearCart extends CartEvent {}
