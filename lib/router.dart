import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:rest_dart_prod/product.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router();

void configureRoutes() {
  // Get /products
  router.get('/products', (Request request) {
    final productListJson = products.map((p) => p.toJson()).toList();
    return Response.ok(jsonEncode(productListJson), headers: {'Content-Type': 'application/json'});
  });

  // GET /products/{id}
  router.get('/products/<id>', (Request request, String id) {
    final product = getProductById(int.parse(id));
    if (product == null) {
      return Response.notFound('Product not found');
    }
    return Response.ok(jsonEncode(product.toJson()), headers: {'Content-Type': 'application/json'});
  });

  // POST /products
  router.post('/products', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final newId = products.isEmpty ? 1 : products.last.id + 1;
    final newProduct = Product(id: newId, name: data['name'], price: data['price']);

    products.add(newProduct);
    return Response.ok(jsonEncode(newProduct.toJson()), headers: {'Content-Type': 'application/json'});
  });

  // PUT /products/{id}
  router.put('/products/<id>', (Request request, String id) async {
    final product = getProductById(int.parse(id));
    if (product == null) {
      return Response.notFound('Product not found');
    }
    
    final body = await request.readAsString();
    final data = jsonDecode(body);
    if (data.containsKey('name')) {
      product.name = data['name'];
    }
    
    if (data.containsKey('price')) {
      product.price = data['price'];
    }

    return Response.ok(jsonEncode(product.toJson()), headers: {'Content-Type': 'application/json'});
  });

  // DELETE /products/{id}
  router.delete('/products/<id>', (Request request, String id) {
    final product = getProductById(int.parse(id));
    if (product == null) {
      return Response.notFound('Product not found');
    }

    products.removeWhere((p) => p.id == int.parse(id));
    return Response.ok('Product with id $id deleted successfully');
  });
}