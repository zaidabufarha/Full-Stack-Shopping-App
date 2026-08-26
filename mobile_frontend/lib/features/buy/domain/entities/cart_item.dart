import 'package:big_cart/features/buy/domain/entities/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem(this.product, this.quantity);
}
