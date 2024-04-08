import 'package:gentle_server/src/model/index.dart';

class ServerJsonOkResponse implements ServerResponse {
  // ignore: no-object-declaration
  final Object? encodableBody;

  const ServerJsonOkResponse({
    required this.encodableBody,
  });
}
