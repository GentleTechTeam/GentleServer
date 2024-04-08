// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';
import 'dart:convert';

import 'package:gentle_server/src/model/index.dart';
import 'package:gentle_server/src/server_route.dart';
import 'package:gentle_server/src/server_router/index.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

class ShelfServerRouter implements ServerRouter<shelf_router.Router> {
  const ShelfServerRouter();

  @override
  shelf_router.Router create({
    required List<ServerRoute> routes,
  }) {
    final shelfRouter = shelf_router.Router();

    for (final route in routes) {
      switch (route.method) {
        case RequestMethod.GET:
          shelfRouter.get(
            route.path,
            _createShelfHandlerFromServerRoute(route),
          );
          break;
        case RequestMethod.POST:
          shelfRouter.post(
            route.path,
            _createShelfHandlerFromServerRoute(route),
          );
          break;
      }
    }

    return shelfRouter;
  }

  static Function _createShelfHandlerFromServerRoute(ServerRoute route) {
    return (
      shelf.Request request,
    ) async {
      final headers = ServerRouteHeaders.fromJson(request.headers);
      final normalizedRequest = await _createServerRequestFromShelfRequest(
        serverRequestType: route.requestType,
        request: request,
      );
      final normalizedParams = ServerRouteParams.fromParamsList(
        request.params.values,
      );

      final response = await route.handle(
        params: route.castHandlerParams(
          params: ServerRouteHandlerParams(
            routeParams: normalizedParams,
            request: normalizedRequest,
            authContext: ServerRouteAuthContext(
              token: headers.token,
            ),
          ),
        ),
      );

      return _createShelfResponseFromServerResponse(response);
    };
  }

  static FutureOr<ServerRequest> _createServerRequestFromShelfRequest({
    required Type serverRequestType,
    required shelf.Request request,
  }) async {
    if (serverRequestType == ServerEmptyRequest) {
      return const ServerEmptyRequest();
    }

    if (serverRequestType == ServerRequestWithJsonMapBody) {
      final requestString = await request.readAsString();

      return ServerRequestWithJsonMapBody(
        jsonData: jsonDecode(requestString) as Map<String, Object?>,
      );
    }

    if (serverRequestType == ServerRequestWithQueryParams) {
      return ServerRequestWithQueryParams(
        queryParameters: request.url.queryParameters,
      );
    }

    throw Exception(
      'Unknown request type: $serverRequestType',
    );
  }

  static shelf.Response
      _createShelfResponseFromServerResponse<T extends ServerResponse>(
    T response,
  ) {
    if (response is ServerEmptyOkResponse) {
      return shelf.Response.ok(null);
    }

    if (response is ServerInternalErrorResponse) {
      return shelf.Response.internalServerError(
        body: response.message,
      );
    }

    if (response is ServerJsonOkResponse) {
      return shelf.Response.ok(
        jsonEncode(response.encodableBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    }

    if (response is ServerNotFoundResponse) {
      return shelf.Response.notFound(
        response.message,
      );
    }

    if (response is ServerPlainOkResponse) {
      return shelf.Response.ok(
        response.message,
      );
    }

    if (response is ServerRedirectResponse) {
      return shelf.Response(
        302,
        headers: {
          'Location': response.redirectUrl,
        },
      );
    }

    throw Exception(
      'Unknown response type: ${T.runtimeType}',
    );
  }
}
