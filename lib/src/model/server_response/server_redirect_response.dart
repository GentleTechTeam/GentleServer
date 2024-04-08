import 'package:gentle_server/src/model/index.dart';

class ServerRedirectResponse implements ServerResponse {
  final String redirectUrl;

  const ServerRedirectResponse({
    required this.redirectUrl,
  });
}
