import 'package:rest_dart_prod/product.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    test('toJson should return correct map', () {
      final product = Product(id: 10, name: 'Test Item', price: 99.99);

      expect(product.toJson(), {
        'id': 10,
        'name': 'Test Item',
        'price': 99.99,
      });
    });
  });

  group('In-memory products database', () {
    test('contains initial products', () {
      expect(products.length, equals(2));
      expect(products[0].id, equals(1));
      expect(products[0].name, equals('Dart Programming Book'));
      expect(products[0].price, equals(49.99));

      expect(products[1].id, equals(2));
      expect(products[1].name, equals('Flutter T-shirt'));
      expect(products[1].price, equals(29.29));
    });
  });

  group('getProductById', () {
    test('returns correct product if ID exists', () {
      final product = getProductById(1);
      expect(product, isNotNull);
      expect(product!.name, equals('Dart Programming Book'));
      expect(product.price, equals(49.99));
    });

    test('returns null if product ID does not exist', () {
      final product = getProductById(999);
      expect(product, isNull);
    });
  });
}
