# GentleServer
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Description

Lightweight and convenient server infrastructure written in Dart.

## Features

- Fast: Fast and convenient creation of any endpoints
- Easy: A couple of lines and your server is running.
- Friendly: An accessible and intuitive interface for working even for novice developers.

## Installation

To add our package to your dependencies, you can include it in your `pubspec.yaml` and call `dart pub get`.

## Usage

Create your first router and pass it to the GentleServer instance. You can find examples in the example folder.

```dart

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

  ```


## License

This project is licensed under the [MIT License](LICENSE).

## Contact

- Author: Gentle Tech Team
- Email: gentletechteam@gmail.com
- Website: [gentletech.net](gentletech.net)

