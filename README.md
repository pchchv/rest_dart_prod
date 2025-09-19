## Runing server
```sh
dart run bin/server.dart
```

## Example curl commands:

##### GET all products:
```sh
curl http://localhost:8080/products
```

##### GET a single product:
```sh
curl http://localhost:8080/products/1
```

#####  POST a new product:
```sh
curl -X POST -H "Content-Type: application/json" -d '{"name": "Dart Mug", "price": 14.99}' http://localhost:8080/products
```

##### PUT to update a product:
```sh
curl -X PUT -H "Content-Type: application/json" -d '{"price": 15.99}' http://localhost:8080/products/3
```

##### DELETE a product:
```sh
curl -X DELETE http://localhost:8080/products/2
```