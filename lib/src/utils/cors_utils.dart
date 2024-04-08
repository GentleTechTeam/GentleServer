import 'dart:async';

import 'package:shelf/shelf.dart';

typedef CorsMiddleware = FutureOr<Response> Function(Request) Function(
  FutureOr<Response> Function(Request),
);

const _corsHeaders = <String, String>{
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': '*',
};

Response? _options(Request request) => (request.method == 'OPTIONS')
    ? Response.ok(null, headers: _corsHeaders)
    : null;
Response _cors(Response response) => response.change(headers: _corsHeaders);

class CorsUtils {
  static CorsMiddleware createCorsMiddleware() => createMiddleware(
        requestHandler: _options,
        responseHandler: _cors,
      );
}
