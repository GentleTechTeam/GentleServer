import 'package:gentle_server/src/model/index.dart';

class ServerRequestWithJsonMapBody implements ServerRequest {
  final Map<String, Object?> jsonData;

  const ServerRequestWithJsonMapBody({
    required this.jsonData,
  });
}
