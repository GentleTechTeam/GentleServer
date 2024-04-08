import 'package:gentle_server/src/model/index.dart';

class ServerRequestWithQueryParams implements ServerRequest {
  final Map<String, String> queryParameters;

  const ServerRequestWithQueryParams({
    required this.queryParameters,
  });
}
