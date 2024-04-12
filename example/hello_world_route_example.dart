import 'dart:convert';

import 'package:gentle_server/src/model/index.dart';
import 'package:gentle_server/src/server_route.dart';

const _routeLogTag = '[HelloWorldRoute]';

typedef HelloWorldRouteDepsFactory = Future<HelloWorldRouteDeps> Function({
  /// place for any dependencies that are needed to create your deps
  required ServerRouteAuthContext authContext,
});

//ignore: prefer-match-file-name
class HelloWorldRoute
    extends ServerRoute<ServerEmptyRouteParams, ServerEmptyRequest> {
  final HelloWorldRouteDepsFactory _depsFactory;

  const HelloWorldRoute({
    required HelloWorldRouteDepsFactory depsFactory,
  }) : _depsFactory = depsFactory;

  @override
  String get path => '/hello-world';

  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  Future<ServerResponse> handle({
    required ServerRouteHandlerParams<ServerEmptyRouteParams,
            ServerEmptyRequest>
        params,
  }) async {
    try {
      /// You can access request data from [params.request]
      final request = params.request;

      print(request);

      final deps = await _depsFactory(
        authContext: params.authContext,
      );

      deps.onDispose();

      return ServerJsonOkResponse(
        encodableBody: json.encode('Hello World!'),
      );
    } catch (error, stackTrace) {
      print(
        '$_routeLogTag error: $error',
      );
      print(stackTrace);

      return ServerInternalErrorResponse(message: error.toString());
    }
  }
}

class HelloWorldRouteDeps {
  /// Place for any deps, that you will need inside your route
  final void Function() onDispose;

  const HelloWorldRouteDeps({
    required this.onDispose,
  });
}
