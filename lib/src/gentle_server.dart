import 'dart:async';
import 'dart:io';

import 'package:gentle_server/src/server_route.dart';
import 'package:gentle_server/src/server_router/shelf_server_router.dart';
import 'package:gentle_server/src/service/index.dart';
import 'package:gentle_server/src/utils/index.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

abstract class GentleServer {
  final BaseConfigurationService configurationService;
  final List<ServerRoute> routes;

  const GentleServer({
    required this.configurationService,
    required this.routes,
  });

  /// Returns the port the server is listening on.
  Future<int> init() async {
    final ip = InternetAddress.anyIPv4;

    HttpUtils.applyHttpOverrides(
      httpsCertificatesCheckDisabled:
          configurationService.httpsCertificatesCheckDisabled,
    );

    final handler = createHandler();
    final server = await serve(
      handler,
      ip,
      configurationService.serverPort,
    );

    return server.port;
  }

  @protected
  FutureOr<Response> Function(Request) createHandler() {
    var middleware = logRequests();

    if (configurationService.corsEnabled) {
      middleware = middleware.addMiddleware(
        CorsUtils.createCorsMiddleware(),
      );
    }

    final router = const ShelfServerRouter().create(routes: routes);

    return middleware.addHandler(router);
  }
}
