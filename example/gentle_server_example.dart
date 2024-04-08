import 'package:gentle_server/gentle_server.dart';

import 'hello_world_route_example.dart';

class GentleConfigurationService implements BaseConfigurationService {
  @override
  bool get corsEnabled => true;
  @override
  bool get httpsCertificatesCheckDisabled => true;
  @override
  int get serverPort => 8080;
}

class DefaultGentleServer extends GentleServer {
  const DefaultGentleServer({
    required super.configurationService,
    required super.routes,
  });

  @override
  BaseConfigurationService get configurationService;
  @override
  List<ServerRoute> get routes;
}

void main() {
  final helloWorldRoute = HelloWorldRoute(
    depsFactory: ({
      required authContext,
    }) async {
      /// Use authContent to get and process auth token, for example.
      return HelloWorldRouteDeps(
        onDispose: () {
          /// Dispose all your dependencies here
          print('HelloWorldRouteDeps disposed');
        },
      );
    },
  );
  final server = DefaultGentleServer(
    configurationService: GentleConfigurationService(),
    routes: [
      helloWorldRoute,
    ],
  );

  server.init().then((port) {
    print('Server listening on port $port');
  });
}
