import 'package:get/get.dart';
import 'package:arekatika/models/product.dart';

class HomeSearchController extends GetxController {
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    products.assignAll([
      Product(
        id: 'goat_curry',
        name: 'Goat Curry Cut – Home Style',
        subtitle: '500 g | Serves 2–3',
        price: 589,
        image: 'assets/images/mutton.png',
      ),
    ]);
    filteredProducts.assignAll(products);
  }

  void updateQuery(String q) {
    final lower = q.toLowerCase();
    filteredProducts.assignAll(
      products.where((p) =>
          p.name.toLowerCase().contains(lower) ||
          p.subtitle.toLowerCase().contains(lower)),
    );
  }
}