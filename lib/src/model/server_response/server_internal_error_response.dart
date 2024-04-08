import 'package:gentle_server/src/model/index.dart';

class ServerInternalErrorResponse implements ServerResponse {
  final String message;

  const ServerInternalErrorResponse({
    required this.message,
  });
}
