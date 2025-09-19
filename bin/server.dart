import 'package:shelf/shelf.dart';
import 'package:rest_dart_prod/router.dart';

void main(List<String> args) async {
  // Configure the pipeline with a logger.
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);
}