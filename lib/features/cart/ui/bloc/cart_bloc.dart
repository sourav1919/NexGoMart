import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../domain/models/cart_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final index = _cartItems.indexWhere((item) => item.id == event.item.id);
      if (index != -1) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: _cartItems[index].quantity + 1);
      } else {
        _cartItems = List.from(_cartItems)..add(event.item);
      }
      emit(CartUpdated(items: List.from(_cartItems)));
    });

    on<RemoveFromCart>((event, emit) {
      _cartItems = List.from(_cartItems)..removeWhere((item) => item.id == event.itemId);
      emit(CartUpdated(items: List.from(_cartItems)));
    });

    on<IncreaseQuantity>((event, emit) {
      final index = _cartItems.indexWhere((item) => item.id == event.itemId);
      if (index != -1) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: _cartItems[index].quantity + 1);
      }
      _cartItems = List.from(_cartItems); // Create a new list reference
      emit(CartUpdated(items: _cartItems));
    });

    on<DecreaseQuantity>((event, emit) {
      final index = _cartItems.indexWhere((item) => item.id == event.itemId);
      if (index != -1) {
        if (_cartItems[index].quantity > 1) {
          _cartItems[index] = _cartItems[index].copyWith(quantity: _cartItems[index].quantity - 1);
        } else {
          _cartItems = List.from(_cartItems)..removeAt(index);
        }
      }
      emit(CartUpdated(items: _cartItems));
    });

    on<ClearCart>((event, emit) {
      _cartItems = []; // Ensure a new reference is created
      emit(CartUpdated(items: _cartItems));
    });
  }
}
