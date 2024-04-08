import 'package:gentle_server/src/model/index.dart';

class ServerNotFoundResponse implements ServerResponse {
  final String message;

  const ServerNotFoundResponse({
    required this.message,
  });
}
