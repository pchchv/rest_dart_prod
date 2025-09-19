class Product {
  final int id;
  String name;
  double price;

  Product({required this.id, required this.name, required this.price});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
  };
}

// Inmemory database.
final List<Product> products = [
  Product(id: 1, name: 'Dart Programming Book', price: 49.99),
  Product(id: 2, name: 'Flutter T-shirt', price: 29.29),
];

// Helper to find a product.
Product? getProductById(int id) {
  try {
    return products.firstWhere((product) => product.id == id);
  } catch (e) {
    return null;
  }
}