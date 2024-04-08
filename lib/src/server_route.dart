import 'package:gentle_server/src/model/index.dart';
import 'package:meta/meta.dart';

/// TODO: Add params to path validation method. (could be outside [ServerRoute])
/// Params([T]) should match [path] arguments.
abstract class ServerRoute<T extends ServerRouteParams,
    R extends ServerRequest> {
  const ServerRoute();

  /// Each param should be in the form of `<paramName>`.
  String get path;

  RequestMethod get method;

  Future<ServerResponse> handle({
    required ServerRouteHandlerParams<T, R> params,
  });

  Type get paramsType => T;

  Type get requestType => R;

  @nonVirtual
  ServerRouteHandlerParams<T, R> castHandlerParams({
    required ServerRouteHandlerParams params,
  }) {
    return ServerRouteHandlerParams<T, R>(
      routeParams: params.routeParams as T,
      request: params.request as R,
      authContext: params.authContext,
    );
  }
}

class ServerRouteHandlerParams<T extends ServerRouteParams,
    R extends ServerRequest> {
  final T routeParams;
  final R request;
  final ServerRouteAuthContext authContext;

  const ServerRouteHandlerParams({
    required this.routeParams,
    required this.request,
    required this.authContext,
  });
}
