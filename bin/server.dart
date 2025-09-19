import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:rest_dart_prod/router.dart';

void main(List<String> args) async {
  // Configure routes.
  configureRoutes();

  // Configure the pipeline with a logger.
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);
  
  // Start server.
  final server = await io.serve(handler, 'localhost', 8080);
  print('Server listening on http://${server.address.host}:${server.port}');
}