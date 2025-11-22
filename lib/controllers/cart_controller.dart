import 'package:get/get.dart';
import 'package:arekatika/models/product.dart';

class CartController extends GetxController {
  final items = <Product, int>{}.obs;

  int get totalItems => items.values.fold(0, (s, q) => s + q);

  int get totalPrice =>
      items.entries.fold(0, (s, e) => s + e.key.price * e.value);

  void addProduct(Product p) {
    items[p] = (items[p] ?? 0) + 1;
    items.refresh();
  }

  void updateQuantity(Product p, int quantity) {
    if (quantity <= 0) {
      items.remove(p);
    } else {
      items[p] = quantity;
    }
    items.refresh();
  }

  void removeProduct(Product p) {
    items.remove(p);
    items.refresh();
  }
}