import 'dart:convert';
import 'package:rest_dart_prod/router.dart';
import 'package:test/test.dart';
import 'package:shelf/shelf.dart';
import 'package:rest_dart_prod/product.dart';

void main() {
  setUp(() {
  products.clear();
  products.addAll([
    Product(id: 1, name: 'Dart Programming Book', price: 49.99),
    Product(id: 2, name: 'Flutter T-shirt', price: 29.29),
  ]);

  configureRoutes(); // adds routes to the global router
});

  Future<Response> handle(Request request) async {
    return router(request);
  }

  group('Product API', () {
    test('GET /products returns all products', () async {
      final request = Request('GET', Uri.parse('http://localhost/products'));
      final response = await handle(request);

      expect(response.statusCode, equals(200));
      final body = jsonDecode(await response.readAsString()) as List;
      expect(body.length, equals(2));
      expect(body[0]['name'], equals('Dart Programming Book'));
    });

    test('GET /products/{id} returns specific product', () async {
      final request = Request('GET', Uri.parse('http://localhost/products/1'));
      final response = await handle(request);

      expect(response.statusCode, equals(200));
      final body = jsonDecode(await response.readAsString());
      expect(body['name'], equals('Dart Programming Book'));
    });

    test('GET /products/{id} returns 404 for non-existing product', () async {
      final request = Request('GET', Uri.parse('http://localhost/products/999'));
      final response = await handle(request);

      expect(response.statusCode, equals(404));
    });

    test('POST /products creates a new product', () async {
      final request = Request(
        'POST',
        Uri.parse('http://localhost/products'),
        body: jsonEncode({'name': 'New Product', 'price': 99.99}),
        headers: {'Content-Type': 'application/json'},
      );

      final response = await handle(request);
      expect(response.statusCode, equals(200));

      final body = jsonDecode(await response.readAsString());
      expect(body['name'], equals('New Product'));
      expect(products.length, equals(3));
    });

    test('PUT /products/{id} updates an existing product', () async {
      final request = Request(
        'PUT',
        Uri.parse('http://localhost/products/1'),
        body: jsonEncode({'name': 'Updated Name', 'price': 59.99}),
        headers: {'Content-Type': 'application/json'},
      );

      final response = await handle(request);
      expect(response.statusCode, equals(200));

      final body = jsonDecode(await response.readAsString());
      expect(body['name'], equals('Updated Name'));
      expect(body['price'], equals(59.99));
    });

    test('DELETE /products/{id} removes a product', () async {
      final request = Request('DELETE', Uri.parse('http://localhost/products/1'));
      final response = await handle(request);

      expect(response.statusCode, equals(200));
      expect(products.any((p) => p.id == 1), isFalse);
    });
  });
}
