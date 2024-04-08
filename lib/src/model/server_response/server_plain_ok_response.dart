import 'package:gentle_server/src/model/index.dart';

class ServerPlainOkResponse implements ServerResponse {
  final String message;

  const ServerPlainOkResponse({
    required this.message,
  });
}
